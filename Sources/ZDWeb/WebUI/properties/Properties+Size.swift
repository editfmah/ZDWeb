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
    @discardableResult
    func maxWidth(_ width: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.maxWidth = '\(width)px';")
        return self
    }
    func maxHeight(_ height: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.maxHeight = '\(height)px';")
        return self
    }
    func minWidth(_ width: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.minWidth = '\(width)px';")
        return self
    }
    func minHeight(_ height: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.minHeight = '\(height)px';")
        return self
    }
}
