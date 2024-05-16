//
//  process+i.swift
//  process+i
//
//  Created by Adrian Herridge on 15/09/2021.
//

import Foundation

public enum FontAwesomeSize {
    case XXSmall
    case XSmall
    case Small
    case Normal
    case Large
    case XLarge
    case XXLarge
    case Jumbo
}

public extension WebRequestContext {
    func i(_ closure: WebComposerClosure) {
        self.block("i") {
            closure()
        }
    }
    func fontAwesome(_ cls: String, size: FontAwesomeSize, color: String? = nil,_ closure: WebComposerClosure? = nil) {
        self.block("i") {
            switch size {
            case .XXSmall:
                self.class(cls + " fa-xs")
            case .XSmall:
                self.class(cls + " fa-sm")
            case .Small:
                self.class(cls + " fa-lg")
            case .Normal:
                self.class(cls + " fa-2x")
            case .Large:
                self.class(cls + " fa-3x")
            case .XLarge:
                self.class(cls + " fa-5x")
            case .XXLarge:
                self.class(cls + " fa-7x")
            case .Jumbo:
                self.class(cls + " fa-10x")
            }
            self.style(.raw(value: "\( color == nil ? "" : " color: \(color!);" )"))
            if let closure = closure {
                closure()
            }
        }
    }
}
