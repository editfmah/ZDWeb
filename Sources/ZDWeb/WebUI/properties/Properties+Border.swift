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
}
