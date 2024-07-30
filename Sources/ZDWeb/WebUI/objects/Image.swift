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
        type = .image
        declare("img", classList: self.builderId , {
            
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        script("\(builderId).src = '\(url)';")
    }
}

