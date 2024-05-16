//
//  File.swift
//  
//
//  Created by Adrian Herridge on 12/10/2021.
//

import Foundation

public extension WebRequestContext {
    func span(_ closure: WebComposerClosure) {
        self.block("span") {
            closure()
        }
    }
    func span(_ text: String, _ closure: WebComposerClosure? = nil) {
        self.block("span") {
            self.output(text)
            if let closure = closure {
                closure()
            }
        }
    }
    func span(`class`: String, _ text: String) {
        self.block("span") {
            self.class(`class`)
            self.output(text)
        }
    }
}
