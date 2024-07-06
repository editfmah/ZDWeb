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
        type = .button
        declare("button", identifier: self.builderId , {
            
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        script("\(builderId).innerText = '\(title)';")
        addClass("btn")
    }
}
