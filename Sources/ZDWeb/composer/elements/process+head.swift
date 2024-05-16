//
//  process+head.swift
//  process+head
//
//  Created by Adrian Herridge on 08/09/2021.
//

import Foundation

public extension WebRequestContext {
    func head(_ closure: WebComposerClosure) {
        self.block("head") {
            closure()
        }
    }
}
