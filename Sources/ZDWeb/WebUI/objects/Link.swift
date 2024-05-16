//
//  Link.swift
//
//
//  Created by Adrian Herridge on 16/05/2024.
//

import Foundation

public class Link : WebElement {
    @discardableResult
    public init(_ text: String, url: String) {
        super.init()
        if withinPickerBuilder == false {
            executingWebThread?.declarative("a", identifier: self.builderId , {
                
            })
            executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            executingWebThread?.builderScript("\(builderId).href = '\(url)';")
            executingWebThread?.builderScript("\(builderId).innerText = '\(text)';")
        } else {
            executingWebThread?.declarative("option", identifier: self.builderId , {
                
            })
            executingWebThread?.builderScript("\(builderId).href = '\(url)';")
            executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            executingWebThread?.builderScript("\(builderId).innerText = '\(text)';")
        }
        addClass("col-md-auto")
    }
}
