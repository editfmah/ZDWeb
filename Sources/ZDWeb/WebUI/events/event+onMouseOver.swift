//
//  File.swift
//  
//
//  Created by Adrian Herridge on 27/05/2024.
//

import Foundation

extension GenericProperties {
    
    @discardableResult
    public func onMouseover(_ actions: [WebAction]) -> Self {
        executionPipeline()?.context?.builderScript("""
        
        \(builderId).addEventListener('mouseover', function() {
        \(compileActions(actions))
        });
        
        """)
        return self
    }
    
    @discardableResult
    public func onMouseover(_ action: WebAction) -> Self {
        return onMouseover([action])
    }
    
}
