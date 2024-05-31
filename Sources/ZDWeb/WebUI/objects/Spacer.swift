//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class Spacer : WebElement {
    @discardableResult
    public override init() {
        super.init()
        executionPipeline()?.context?.declarative("div", identifier: self.builderId , {
            
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("col")
        addClass("mx-none")
    }
}
