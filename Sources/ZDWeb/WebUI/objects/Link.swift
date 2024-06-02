//
//  Link.swift
//
//
//  Created by Adrian Herridge on 16/05/2024.
//

import Foundation

public class Link : WebElement {
    @discardableResult
    public init(_ text: String, url: String) {
        super.init()
        executionPipeline()?.types[self.builderId] = .link
        if executionPipeline()?.withinPickerBuilder == false {
            executionPipeline()?.context?.declarative("a", identifier: self.builderId , {
                
            })
            executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            executionPipeline()?.context?.builderScript("\(builderId).href = '\(url)';")
            executionPipeline()?.context?.builderScript("\(builderId).innerText = '\(text)';")
        } else {
            executionPipeline()?.context?.declarative("option", identifier: self.builderId , {
                
            })
            executionPipeline()?.context?.builderScript("\(builderId).href = '\(url)';")
            executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            executionPipeline()?.context?.builderScript("\(builderId).innerText = '\(text)';")
        }
        addClass("col")
    }
}
