//
//  File.swift
//  
//
//  Created by Adrian Herridge on 14/11/2021.
//

import Foundation
public extension WebRequestContext {
    func pre(_ value: String, _ closure: WebComposerClosure? = nil) {
        self.block("pre") {
            closure?()
            self.output(value)
        }
    }
}
