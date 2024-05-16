//
//  process+div.swift
//  process+div
//
//  Created by Adrian Herridge on 08/09/2021.
//

import Foundation

public extension WebRequestContext {
    func div(_ closure: WebComposerClosure) {
        self.block("div") {
            closure()
        }
    }
    func div(_ cls: String, _ closure: WebComposerClosure) {
        self.block("div") {
            self.class(cls)
            closure()
        }
    }
    func divclear(_ closure: WebComposerClosure? = nil) {
        self.block("div") {
            self.style(.raw(value: "clear: both;"))
            closure?()
        }
    }
}
