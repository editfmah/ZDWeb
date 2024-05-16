//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

// other items
class Button : WebElement {
    @discardableResult
    init(_ title: String) {
        super.init()
        executingWebThread?.declarative("button", identifier: self.builderId , {
            
        })
        executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        executingWebThread?.builderScript("\(builderId).innerText = '\(title)';")
        addClass("btn")
    }
}
