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
    @discardableResult
    func maxHeight(_ height: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.maxHeight = '\(height)px';")
        return self
    }
    @discardableResult
    func minWidth(_ width: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.minWidth = '\(width)px';")
        return self
    }
    @discardableResult
    func minHeight(_ height: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.minHeight = '\(height)px';")
        return self
    }
    @discardableResult
    func justifyContent(_ justify: WebContentAlignment) -> Self {
        // use bootstrap classes to align the content
        switch justify {
        case .start:
            executionPipeline()?.context?.builderScript("\(builderId).classList.add('justify-content-start');")
        case .end:
            executionPipeline()?.context?.builderScript("\(builderId).classList.add('justify-content-end');")
        case .center:
            executionPipeline()?.context?.builderScript("\(builderId).classList.add('justify-content-center');")
        case .between:
            executionPipeline()?.context?.builderScript("\(builderId).classList.add('justify-content-between');")
        case .around:
            executionPipeline()?.context?.builderScript("\(builderId).classList.add('justify-content-around');")
        case .evenly:
            executionPipeline()?.context?.builderScript("\(builderId).classList.add('justify-content-evenly');")
        }
        return self
    }
}
