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
        executionPipeline()?.context?.declarative("form", identifier: self.builderId , {
            body()
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}
