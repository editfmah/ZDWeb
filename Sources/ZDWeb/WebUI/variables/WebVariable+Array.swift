//
//  WebVariable+Array.swift
//
//
//  Created by Adrian Herridge on 01/08/2024.
//

import Foundation

public class WArray: WebVariable {
    
    internal var internalValues: Set<String> = [] {
        didSet {
            let valuesArray = Array(internalValues)
            let valuesString = valuesArray.map { "'\($0)'" }.joined(separator: ",")
            script("\(builderId) = [\(valuesString)];")
        }
    }
    
    public init(_ values: [String] = []) {
        super.init()
        internalValues = Set(values)
        let valuesArray = Array(internalValues)
        let valuesString = valuesArray.map { "'\($0)'" }.joined(separator: ",")
        script("/* builder-object-reference */ var \(builderId) = [\(valuesString)];")
    }
    
    public func add(_ value: String) {
        internalValues.insert(value)
    }
    
    public func remove(_ value: String) {
        internalValues.remove(value)
    }
    
    public func contains(_ value: String) -> Bool {
        return internalValues.contains(value)
    }
    
    public override func name(_ name: String) -> Self {
        
        formName = name
        script("\(builderId).name = '\(name)';")

        // Create the hidden input field using the declare function
        declare("input", classList: "hidden-input", id: "hiddenInput_\(builderId)", attributes: ["type": "hidden", "name": name, "value": "\(builderId)"]) {
            // No additional body content
        }

        // Add observer to update hidden input field when `builderId` changes
        script("""
        var lastValue\(builderId) = JSON.stringify(\(builderId));
        var valueInterval\(builderId) = setInterval(function() {
            var currentValue = JSON.stringify(\(builderId));
            if(currentValue != lastValue\(builderId)) {
                document.getElementById('hiddenInput_\(builderId)').value = currentValue;
                lastValue\(builderId) = currentValue;
            }
        }, 500);
        """)

        return self
        
    }
}
