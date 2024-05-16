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
        executingWebThread?.declarative("img", identifier: self.builderId , {
            
        })
        executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        executingWebThread?.builderScript("\(builderId).src = '\(url)';")
    }
}

