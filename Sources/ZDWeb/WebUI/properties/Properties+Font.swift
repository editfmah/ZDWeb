//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public extension GenericProperties {
    @discardableResult
    func font(_ font: WebFontSize) -> Self {
        switch font {
        case .veryLargeTitle:
            script("\(builderId).style.fontSize = '64px';")
        case .largeTitle:
            script("\(builderId).style.fontSize = '32px';")
        case .title:
            script("\(builderId).style.fontSize = '24px';")
        case .title2:
            script("\(builderId).style.fontSize = '20px';")
        case .normal:
            script("\(builderId).style.fontSize = '16px';")
        case .subtitle:
            script("\(builderId).style.fontSize = '14px';")
        case .caption:
            script("\(builderId).style.fontSize = '12px';")
        case .footnote:
            script("\(builderId).style.fontSize = '10px';")
        case .custom(let size):
            script("\(builderId).style.fontSize = '\(size)px';")
        }
        return self
    }
    @discardableResult
    func fontfamily(_ family: String) -> Self {
        script("\(builderId).style.fontFamily = '\(family)';")
        return self
    }
    @discardableResult
    func bold() -> Self {
        script("\(builderId).style.fontWeight = 'bold';")
        return self
    }
    
    @discardableResult
    func lightweight() -> Self {
        script("\(builderId).style.fontWeight = 'lighter';")
        return self
    }
    
    @discardableResult
    func italic() -> Self {
        script("\(builderId).style.fontStyle = 'italic';")
        return self
    }
    
    @discardableResult
    func strikethrough() -> Self {
        script("\(builderId).style.textDecoration = 'line-through';")
        return self
    }
    
    @discardableResult
    func underline(_ value: Bool) -> Self {
        script("\(builderId).style.textDecoration = '\(value ? "underline" : "none")';")
        return self
    }
    
}
