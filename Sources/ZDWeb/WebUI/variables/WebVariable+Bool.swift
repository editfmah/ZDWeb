//
//  WBool.swift
//  
//
//  Created by Adrian Herridge on 31/05/2024.
//

import Foundation

public class WBool : WebVariable {
    
    internal var internalValue: Bool = false {
        didSet {
            script("\(builderId) = \(internalValue == true ? "true" : "false");")
        }
    }
    
    public init(_ value: Bool) {
        super.init()
        internalValue = value
        script("/* builder-object-reference */ var \(builderId) = \(internalValue == true ? "true" : "false");")
    }
    
    public func conditions(_ conditions: [(variable: WebVariable, operator: Operator)]) {
        for condition in conditions {
            let instanceId = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
            script("""
// condition tester and publisher
// default to true and only set false on mismatched conditions of any/or
\(builderId) = true;
var testCondition\(builderId) = function() {
    if(\(condition.variable.builderId) \(condition.operator.javascriptCondition)) {  } else { \(builderId) = false; }
};
    let condition\(instanceId) = setInterval(testCondition\(instanceId), 500);
""")
        }
    }
    
    public func condition(_ variable: WebVariable, operator: Operator) {
        
        executionPipeline()?.context?.builderScript("""
var testCondition\(builderId) = function() {
    if(\(variable.builderId) \(`operator`.javascriptCondition)) { \(builderId) = true; } else { \(builderId) = false; }
};
let condition\(builderId) = setInterval(testCondition\(builderId), 500);
""")
        
    }
    public func set(_ value: Bool) {
        internalValue = value
        executionPipeline()?.context?.script("\(builderId) = \(internalValue == true ? "true" : "false");")
    }
    public func toggle() {
        internalValue = !internalValue
        executionPipeline()?.context?.script("\(builderId) = \(internalValue == true ? "true" : "false");")
    }
}
