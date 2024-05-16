//
//  process+lists.swift
//  WebServer
//
//  Created by Adrian Herridge on 01/10/2021.
//

import Foundation

public extension WebRequestContext {
    func ul(_ closure: WebComposerClosure) {
        self.block("ul") {
            closure()
        }
    }
    func li(_ closure: WebComposerClosure) {
        self.block("li") {
            closure()
        }
    }
}
