//
//  process+h1.swift
//  WebServer
//
//  Created by Adrian Herridge on 29/08/2021.
//

import Foundation

public extension WebRequestContext {
    func h1(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("h1") {
            self.output(value)
            closure?()
        }
    }
    func h2(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("h2") {
            self.output(value)
            closure?()
        }
    }
    func h3(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("h3") {
            self.output(value)
            closure?()
        }
    }
    func h4(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("h4") {
            self.output(value)
            closure?()
        }
    }
    func h5(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("h5") {
            self.output(value)
            closure?()
        }
    }
    func h6(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("h6") {
            self.output(value)
            closure?()
        }
    }
    func h7(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("h7") {
            self.output(value)
            closure?()
        }
    }
    func h8(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("h8") {
            self.output(value)
            closure?()
        }
    }
    func paragraph(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("p") {
            self.output(value)
            closure?()
        }
    }
}
