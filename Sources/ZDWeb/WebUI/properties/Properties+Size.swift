//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation
public extension GenericProperties {
    @discardableResult
    func width(_ width: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.width = '\(width)px';")
        return self
    }
    @discardableResult
    func height(_ height: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.height = '\(height)px';")
        return self
    }
}
