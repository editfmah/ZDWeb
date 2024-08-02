//
//  File.swift
//
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

protocol WebVariableProperties {
    var builderId: String { get }
}

public class WebVariable : WebCommonInterop {
    
    public var formName: String? = nil
    
    public func name(_ name: String) -> Self {
        
        formName = name
        script("function set\(name.md5())(value) { \(builderId) = value; };")

        // Create the hidden input field using the declare function
        declare("input", classList: "hidden-input", id: "hiddenInput_\(builderId)", attributes: ["type": "hidden", "name": name, "value": "\(builderId)"]) {
            // No additional body content
        }

        // Add observer to update hidden input field when `builderId` changes
        script("""
        var lastValue\(builderId) = \(builderId);
        var valueInterval\(builderId) = setInterval(function() {
            if(\(builderId) != lastValue\(builderId)) {
                document.getElementById('hiddenInput_\(builderId)').value = \(builderId);
                lastValue\(builderId) = \(builderId);
            }
        }, 500);
        """)

        return self
        
    }

    
    public func onValueChange(_ actions: [WebAction]) -> Self {
        // when the value of the variable changes, execute the actions
        executionPipeline()?.context?.builderScript("""
var lastValue\(builderId) = \(builderId);
var valueInterval\(builderId) = setInterval(function() {
    if(\(builderId) != lastValue\(builderId)) {
        \(CompileActions(actions, builderId: builderId))
        lastValue\(builderId) = \(builderId);
    }
}, 500);
""")
        return self
    }
    
}
