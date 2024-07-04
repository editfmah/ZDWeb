//
//  List.swift
//
//
//  Created by Adrian Herridge on 09/06/2024.
//

import Foundation

// other items
public class List : WebButtonElement {
    @discardableResult
    public init(_ body: WebComposerClosure) {
        super.init()
        executionPipeline()?.context?.declarative("div", identifier: self.builderId , {
            Scrollview(direction: .vertical) {
                body()
            }
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("col")
    }
}
