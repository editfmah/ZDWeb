//
//  process+body.swift
//  WebServer
//
//  Created by Adrian Herridge on 29/08/2021.
//

import Foundation

public extension WebRequestContext {
    func body(_ closure: WebComposerClosure) {
        self.block("body") {
            closure()
        }
    }
}
