//
//  File.swift
//  
//
//  Created by Adrian Herridge on 20/04/2023.
//

import Foundation

public extension WebRequestContext {

    func small(_ text: String, class: String? = nil, _ closure: WebComposerClosure? = nil) {
        self.block("small") {
            if let `class` = `class` {
                self.class(`class`)
            }
            self.output(text)
            if let closure = closure {
                closure()
            }
        }
    }
    
    func mark(_ text: String, class: String? = nil, _ closure: WebComposerClosure? = nil) {
        self.block("mark") {
            if let `class` = `class` {
                self.class(`class`)
            }
            self.output(text)
            if let closure = closure {
                closure()
            }
        }
    }
    
    func strong(_ text: String, class: String? = nil, _ closure: WebComposerClosure? = nil) {
        self.block("strong") {
            if let `class` = `class` {
                self.class(`class`)
            }
            self.output(text)
            if let closure = closure {
                closure()
            }
        }
    }
    
    func italic(_ text: String, class: String? = nil, _ closure: WebComposerClosure? = nil) {
        self.block("em") {
            if let `class` = `class` {
                self.class(`class`)
            }
            self.output(text)
            if let closure = closure {
                closure()
            }
        }
    }
    
}
