//
//  event+onClick.swift
//
//
//  Created by Adrian Herridge on 27/05/2024.
//

import Foundation

extension GenericProperties {
    
    @discardableResult
    public func onClick(_ actions: [WebAction]) -> Self {
        executionPipeline()?.context?.builderScript("""
        \(builderId).addEventListener('click', function() {
        \(compileActions(actions))
        });
        
        """)
        return self
    }
    
    @discardableResult
    public func onClick(_ action: WebAction) -> Self {
        return onClick([action])
    }
    
}

