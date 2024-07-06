//
//  File.swift
//  
//
//  Created by Adrian Herridge on 17/05/2024.
//

import Foundation

public class Form : WebFormElement {
    @discardableResult
    public init(_ body: WebComposerClosure) {
        super.init()
        declare("form", identifier: self.builderId , {
            body()
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}
