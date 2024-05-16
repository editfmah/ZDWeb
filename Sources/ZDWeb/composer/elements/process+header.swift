//
//  File.swift
//  
//
//  Created by Adrian Herridge on 30/04/2022.
//

import Foundation

extension WebRequestContext {
    public func header(_ closure: WebComposerClosure) {
        self.block("header") {
            closure()
        }
    }
    public func main(_ closure: WebComposerClosure) {
        self.block("main") {
            closure()
        }
    }
    public func footer(_ closure: WebComposerClosure) {
        self.block("footer") {
            closure()
        }
    }
}
