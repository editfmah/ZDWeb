//
//  Socket+File.swift
//  ZDWeb
//
//  Copyright © 2024 Adrian Herridge, ZestDeck Limited.  All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os (Linux)
// swiftlint:disable type_name function_parameter_count
    struct sf_hdtr { }

    private func sendfileImpl(_ source: UnsafeMutablePointer<FILE>, _ target: Int32, _: off_t, _: UnsafeMutablePointer<off_t>, _: UnsafeMutablePointer<sf_hdtr>, _: Int32) -> Int32 {
        var buffer = [UInt8](repeating: 0, count: 1024)
        while true {
                let readResult = fread(&buffer, 1, buffer.count, source)
                guard readResult > 0 else {
                    return Int32(readResult)
                }
                var writeCounter = 0
                while writeCounter < readResult {
                        let writeResult = buffer.withUnsafeBytes { (ptr) -> Int in
                            let start = ptr.baseAddress! + writeCounter
                            let len = readResult - writeCounter
#if os(Linux)
                            return send(target, start, len, Int32(MSG_NOSIGNAL))
#else
                            return write(target, start, len)
#endif
                        }
                        guard writeResult > 0 else {
                            return Int32(writeResult)
                        }
                        writeCounter += writeResult
                }
        }
    }
#endif

extension Socket {

    public func writeFile(_ file: String.File, start: Int64? = 0, length: Int32? = 0) throws {
        
#if os(iOS) || os(tvOS) || os (Linux)
        var len: off_t = Int(length ?? 0)
        let start: Int = Int(start ?? 0)
#else
        var len: off_t = Int64(length ?? 0)
        let start: Int64 = Int64(start ?? 0)
#endif
        
        var sf: sf_hdtr = sf_hdtr()
        
        #if os(iOS) || os(tvOS) || os (Linux)
        let result = sendfileImpl(file.pointer, self.socketFileDescriptor, start, &len, &sf, 0)
        #else
        let result = sendfile(fileno(file.pointer), self.socketFileDescriptor, start, &len, &sf, 0)
        #endif

        if result == -1 {
            throw SocketError.writeFailed("sendfile: " + Errno.description())
        }
    }
}
