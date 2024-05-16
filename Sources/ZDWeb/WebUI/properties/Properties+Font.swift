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
            executingWebThread?.builderScript("\(builderId).style.fontSize = '32px';")
        case .title:
            executingWebThread?.builderScript("\(builderId).style.fontSize = '24px';")
        case .title2:
            executingWebThread?.builderScript("\(builderId).style.fontSize = '20px';")
        case .normal:
            executingWebThread?.builderScript("\(builderId).style.fontSize = '16px';")
        case .subtitle:
            executingWebThread?.builderScript("\(builderId).style.fontSize = '14px';")
        case .caption:
            executingWebThread?.builderScript("\(builderId).style.fontSize = '12px';")
        case .footnote:
            executingWebThread?.builderScript("\(builderId).style.fontSize = '10px';")
        }
        return self
    }
    @discardableResult
    func fontfamily(_ family: String) -> Self {
        executingWebThread?.builderScript("\(builderId).style.fontFamily = '\(family)';")
        return self
    }
}
