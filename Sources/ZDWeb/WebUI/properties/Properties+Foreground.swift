//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation
public extension GenericProperties {
    @discardableResult
    func foreground(_ color: WebColor) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.color = '\(color.rgba)';")
        return self
    }
}
