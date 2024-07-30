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
        declare("div", classList: self.builderId , {
            
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("col")
        addClass("mx-none")
    }
}
