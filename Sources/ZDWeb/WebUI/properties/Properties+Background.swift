//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public extension GenericProperties {
    @discardableResult
    func background(_ color: WebColor) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.backgroundColor = '\(color.rgba)';")
        return self
    }
}
