//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public extension GenericProperties {
    @discardableResult
    func border(_ color: WebColor, width: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.border = '\(width)px solid \(color.rgba)';")
        return self
    }
    @discardableResult
    func border(_ position: WebAreaPosition, _ color: WebColor, width: Int) -> Self {
        switch position {
        case .leading:
            executionPipeline()?.context?.builderScript("\(builderId).style.borderLeft = '\(width)px solid \(color.hex)';")
        case .trailing:
            executionPipeline()?.context?.builderScript("\(builderId).style.borderRight = '\(width)px solid \(color.hex)';")
        case .top:
            executionPipeline()?.context?.builderScript("\(builderId).style.borderTop = '\(width)px solid \(color.hex)';")
        case .bottom:
            executionPipeline()?.context?.builderScript("\(builderId).style.borderBottom = '\(width)px solid \(color.hex)';")
        case .all:
            executionPipeline()?.context?.builderScript("\(builderId).style.border = '\(width)px solid \(color.hex)';")
        }
        return self
    }
    @discardableResult
    func border(_ positions: [WebAreaPosition], _ color: WebColor, width: Int) -> Self {
        for position in positions {
            return border(position, color, width: width)
        }
        return self
    }
}
