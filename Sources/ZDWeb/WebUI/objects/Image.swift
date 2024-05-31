//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class Image : WebImageElement {
    @discardableResult
    public init(url: String) {
        super.init()
        executionPipeline()?.types[self.builderId] = .image
        executionPipeline()?.context?.declarative("img", identifier: self.builderId , {
            
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        executionPipeline()?.context?.builderScript("\(builderId).src = '\(url)';")
    }
}

