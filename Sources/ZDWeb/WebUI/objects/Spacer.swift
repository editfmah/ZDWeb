//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

class Spacer : WebElement {
    @discardableResult
    override init() {
        super.init()
        executingWebThread?.declarative("div", identifier: self.builderId , {
            
        })
        executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("col")
        addClass("mx-none")
    }
}
