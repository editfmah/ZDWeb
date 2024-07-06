//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class HStack : WebElement {
    @discardableResult
    public init(_ body: WebComposerClosure) {
        super.init()
        declare("div", identifier: self.builderId , {
            body()
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("row")
        
    }
}
