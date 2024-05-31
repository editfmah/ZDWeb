//
//  File.swift
//
//
//  Created by Adrian Herridge on 28/05/2024.
//

import Foundation

extension GenericProperties {
        
        @discardableResult
        public func onEnable(_ actions: [WebAction]) -> Self {

            executionPipeline()?.context?.builderScript("""
var lastEnabledValue\(builderId) = false;

// repeating interval to monitor for the disabled attribute changing or being removed
var enableInterval\(builderId) = setInterval(function() {
    if(\(builderId).disabled != lastEnabledValue\(builderId)) {
        if(!\(builderId).disabled) {
            \(builderId).onEnable();
        }
        lastEnabledValue\(builderId) = \(builderId).disabled;
    }
}, 500);

\(builderId).onEnable = function() {
    \(compileActions(actions))
};
""")
            
            return self
        }
        
        @discardableResult
        public func onEnable(_ action: WebAction) -> Self {
            return onEnable([action])
        }
    
}
