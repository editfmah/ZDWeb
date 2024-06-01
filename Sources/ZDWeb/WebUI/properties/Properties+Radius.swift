//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation
public extension GenericProperties {
    @discardableResult
    func radius(_ radius: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.borderRadius = '\(radius)px';")
        return self
    }
    @discardableResult
    func radius(_ position: WebCornerPosition, _ radius: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.border\(position.rawValue)Radius = '\(radius)px';")
        return self
    }
    @discardableResult
    func radius(_ positions: [WebCornerPosition], _ radius: Int) -> Self {
        for position in positions {
            executionPipeline()?.context?.builderScript("\(builderId).style.border\(position.rawValue)Radius = '\(radius)px';")
        }
        return self
    }
}
