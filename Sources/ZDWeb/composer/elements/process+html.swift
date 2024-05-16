//
//  process+html.swift
//  WebServer
//
//  Created by Adrian Herridge on 29/08/2021.
//

import Foundation

public extension WebRequestContext {
    @discardableResult
    func html(language: String? = nil, _ closure: WebComposerClosure) -> WebRequestContext {
        self.block("html") {
            if let lang = language {
                self.property(property: "lang", value: lang)
            }
            closure()
        }
        return self
    }
}
