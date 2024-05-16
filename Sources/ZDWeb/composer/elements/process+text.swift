//
//  process+text.swift
//  WebServer
//
//  Created by Adrian Herridge on 27/09/2021.
//

import Foundation

public extension WebRequestContext {
    func text(_ text: String?) {
        if let txt = text {
            self.output(txt)
        }
    }
    func strong(_ text: String?) {
        if let txt = text {
            self.output("<strong>\(txt)</strong>")
        }
    }
}
