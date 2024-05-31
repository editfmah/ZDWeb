//
//  File.swift
//  
//
//  Created by Adrian Herridge on 27/05/2024.
//

import Foundation

extension GenericProperties {
    
    @discardableResult
    public func onMouseLeave(_ actions: [WebAction]) -> Self {
        executionPipeline()?.context?.builderScript("""
        
        \(builderId).addEventListener('mouseleave', function() {
        \(compileActions(actions))
        });
        
        """)
        return self
    }
    
    @discardableResult
    public func onMouseLeave(_ action: WebAction) -> Self {
        return onMouseLeave([action])
    }
    
}

