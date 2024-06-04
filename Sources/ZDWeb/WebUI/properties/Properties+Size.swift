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
    func align(_ align: WebContentAlignment) -> Self {
        return self.align([align])
    }
    
    @discardableResult
    func align(_ align: [WebContentAlignment]) -> Self {
        for alignment in align {
            switch alignment {
            case .left:
                executionPipeline()?.context?.builderScript("\(builderId).classList.add('justify-content-start');")
            case .right:
                executionPipeline()?.context?.builderScript("\(builderId).classList.add('justify-content-end');")
            case .middle:
                executionPipeline()?.context?.builderScript("\(builderId).classList.add('align-content-center');")
            case .top:
                executionPipeline()?.context?.builderScript("\(builderId).classList.add('align-content-start');")
            case .bottom:
                executionPipeline()?.context?.builderScript("\(builderId).classList.add('align-content-end');")
            case .center:
                executionPipeline()?.context?.builderScript("\(builderId).classList.add('justify-content-center');")
            }
        }
        return self
    }
}
