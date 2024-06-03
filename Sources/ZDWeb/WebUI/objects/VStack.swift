//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public enum VStackMode {
    case auto
}

public class VStack : WebElement {
    @discardableResult
    public init(_ mode: VStackMode? = nil, _ body: WebComposerClosure) {
        super.init()
        executionPipeline()?.context?.declarative("div", identifier: self.builderId , {
            body()
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        if let mode = mode {
            switch mode {
            case .auto:
                addClass("col-auto")
            }
        } else {
            addClass("col")
        }
    }
}

