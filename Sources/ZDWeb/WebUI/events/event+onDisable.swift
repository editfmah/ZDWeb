//
//  File.swift
//
//
//  Created by Adrian Herridge on 28/05/2024.
//

import Foundation

extension GenericProperties {
        
        @discardableResult
        public func onDisable(_ actions: [WebAction]) -> Self {
            
            executionPipeline()?.context?.builderScript("""

var lastDisableValue\(builderId) = false;

// repeating interval to monitor for the disabled attribute changing
var disableInterval\(builderId) = setInterval(function() {
    if(\(builderId).disabled != lastDisableValue\(builderId)) {
        if(\(builderId).disabled) {
            \(builderId).onDisable();
        }
        lastDisableValue\(builderId) = \(builderId).disabled;
    }
}, 500);

\(builderId).onDisable = function() {
    \(compileActions(actions))
};

""")

            return self
        }
        
        @discardableResult
        public func onDisable(_ action: WebAction) -> Self {
            return onDisable([action])
        }
    
}
