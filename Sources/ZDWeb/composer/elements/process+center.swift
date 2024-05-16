//
//  process+center.swift
//  process+center
//
//  Created by Adrian Herridge on 09/09/2021.
//

import Foundation

public extension WebRequestContext {
    func center(_ closure: WebComposerClosure) {
        self.block("center") {
            closure()
        }
    }
}
