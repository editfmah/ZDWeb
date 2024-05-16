//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class VStack : WebElement {
    @discardableResult
    public public init(_ body: WebComposerClosure) {
        super.init()
        executingWebThread?.declarative("div", identifier: self.builderId , {
            body()
        })
        executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("col-md-auto")
    }
}

