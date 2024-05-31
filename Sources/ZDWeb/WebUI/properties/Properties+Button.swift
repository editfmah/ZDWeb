//
//  Properties+Button.swift
//
//
//  Created by Adrian Herridge on 20/05/2024.
//

import Foundation

extension GenericButtonProperties {
    
    @discardableResult
    public func type(_ type: WebButtonType) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).type = '\(type.rawValue)';")
        return self
    }
    
    @discardableResult
    public func style(_ style: WebStyle) -> Self {
        // set the bootstrap 5 button style
        executionPipeline()?.context?.builderScript("\(builderId).classList.add('btn');")
        executionPipeline()?.context?.builderScript("\(builderId).classList.add('\(style.buttonStyleClass)');")
        return self
    }
    
    @discardableResult
    public func conditions(_ conditions: [WebVariable]) -> Self {
        // evaluate the conditions and enable or disable the button
        
        return self
    }
}
