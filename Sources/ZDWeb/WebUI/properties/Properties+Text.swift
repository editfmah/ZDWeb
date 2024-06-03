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
    
}
