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
            executionPipeline()?.context?.builderScript("\(builderId).style.fontSize = '64px';")
        case .largeTitle:
            executionPipeline()?.context?.builderScript("\(builderId).style.fontSize = '32px';")
        case .title:
            executionPipeline()?.context?.builderScript("\(builderId).style.fontSize = '24px';")
        case .title2:
            executionPipeline()?.context?.builderScript("\(builderId).style.fontSize = '20px';")
        case .normal:
            executionPipeline()?.context?.builderScript("\(builderId).style.fontSize = '16px';")
        case .subtitle:
            executionPipeline()?.context?.builderScript("\(builderId).style.fontSize = '14px';")
        case .caption:
            executionPipeline()?.context?.builderScript("\(builderId).style.fontSize = '12px';")
        case .footnote:
            executionPipeline()?.context?.builderScript("\(builderId).style.fontSize = '10px';")
        case .custom(let size):
            executionPipeline()?.context?.builderScript("\(builderId).style.fontSize = '\(size)px';")
        }
        return self
    }
    @discardableResult
    func fontfamily(_ family: String) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.fontFamily = '\(family)';")
        return self
    }
    @discardableResult
    func bold() -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.fontWeight = 'bold';")
        return self
    }
    
    @discardableResult
    func lightweight() -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.fontWeight = 'lighter';")
        return self
    }
    
    @discardableResult
    func italic() -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.fontStyle = 'italic';")
        return self
    }
    
    @discardableResult
    func strikethrough() -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.textDecoration = 'line-through';")
        return self
    }
    
    @discardableResult
    func underline(_ value: Bool) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.textDecoration = '\(value ? "underline" : "none")';")
        return self
    }
    
}
