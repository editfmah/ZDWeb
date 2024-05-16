//
//  File.swift
//  
//
//  Created by Adrian Herridge on 30/04/2022.
//

import Foundation

public extension WebRequestContext {
    func nav(_ closure: WebComposerClosure) {
        self.block("nav") {
            closure()
        }
    }
}
