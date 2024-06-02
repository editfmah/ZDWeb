//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class VStack : WebElement {
    @discardableResult
    public init(_ body: WebComposerClosure) {
        super.init()
        executionPipeline()?.context?.declarative("div", identifier: self.builderId , {
            body()
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("col")
    }
}

