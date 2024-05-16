//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

extension GenericProperties {
    @discardableResult
    func onClick(toggle: WBool) -> Self {
        executingWebThread?.builderScript("\(builderId).onclick = function() { \(toggle.builderId) = !\(toggle.builderId) }")
        return self
    }
    @discardableResult
    func onClick(script: String) -> Self {
        executingWebThread?.builderScript("""
\(builderId).onclick = function() { 
    \(script)
};
""")
        return self
    }
}
