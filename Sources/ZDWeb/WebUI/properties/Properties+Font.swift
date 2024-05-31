//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public extension GenericProperties {
    @discardableResult
    func font(_ font: WebFont) -> Self {
        switch font {
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
        }
        return self
    }
    @discardableResult
    func fontfamily(_ family: String) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.fontFamily = '\(family)';")
        return self
    }
}
