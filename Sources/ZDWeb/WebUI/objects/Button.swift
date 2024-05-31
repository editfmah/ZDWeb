//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

// other items
public class Button : WebButtonElement {
    @discardableResult
    public init(_ title: String) {
        super.init()
        executionPipeline()?.types[self.builderId] = .button
        executionPipeline()?.context?.declarative("button", identifier: self.builderId , {
            
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        executionPipeline()?.context?.builderScript("\(builderId).innerText = '\(title)';")
        addClass("btn")
    }
}
