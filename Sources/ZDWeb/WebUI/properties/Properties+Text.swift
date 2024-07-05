//
//  File.swift
//  
//
//  Created by Adrian Herridge on 03/06/2024.
//

import Foundation

extension GenericProperties {
    
    @discardableResult
    public func textalign(_ align: WebTextAlignment) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.textAlign = '\(align.rawValue)';")
        return self
    }
    
    @discardableResult
    public func wrap(_ type: WebTextWrapType) -> Self {
        // set properties for the style `text-wrap`
        executionPipeline()?.context?.builderScript("\(builderId).style.textWrap = '\(type.rawValue)';")
        return self
    }
    
}
