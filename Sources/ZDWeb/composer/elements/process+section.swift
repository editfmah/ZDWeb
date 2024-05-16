//
//  File.swift
//  
//
//  Created by Adrian Herridge on 30/04/2022.
//

import Foundation

public extension WebRequestContext {
    func section(_ closure: WebComposerClosure) {
        self.block("section") {
            closure()
        }
    }
    func sectionHeader(title: String, textColour: String? = nil, lineColour: String? = nil) {
        self.row(cls: "ms-1 me-1") {
            self.h5(title) {
                self.class("border border-1 border-top-0 border-start-0 border-end-0 \(lineColour == nil ? "border-secondary-50" : "\(lineColour!)") \(textColour == nil ? "text-black-50" : "\(textColour!)") p-1")
            }
        }
    }
}
