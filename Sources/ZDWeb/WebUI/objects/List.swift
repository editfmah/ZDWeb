//
//  List.swift
//
//
//  Created by Adrian Herridge on 09/06/2024.
//

import Foundation

// other items
public class List : WebButtonElement {
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
