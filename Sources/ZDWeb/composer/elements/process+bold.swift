//
//  process+bold.swift
//  
//
//  Created by Adrian Herridge on 15/12/2022.
//

import Foundation

public extension WebRequestContext {
    func bold(_ closure: WebComposerClosure) {
        self.block("b") {
            closure()
        }
    }
}
