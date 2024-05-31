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
}
