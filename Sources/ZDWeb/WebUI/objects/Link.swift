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
        type = .link
        if isPicker == false {
            declare("a", classList: self.builderId , {
                
            })
            script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            script("\(builderId).href = '\(url)';")
            script("\(builderId).innerText = '\(text)';")
        } else {
            declare("option", classList: self.builderId , {
                
            })
            script("\(builderId).href = '\(url)';")
            script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            script("\(builderId).innerText = '\(text)';")
        }
        addClass("col")
    }
}
