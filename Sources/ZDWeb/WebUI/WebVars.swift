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

public class WBool : WebVariable {
    
    internal var internalValue: Bool = false {
        didSet {
            executionPipeline()?.context?.builderScript("\(builderId) = \(internalValue == true ? "true" : "false");")
        }
    }
    
    init(_ value: Bool) {
        super.init()
        internalValue = value
        executionPipeline()?.context?.builderScript("var \(builderId) = \(internalValue == true ? "true" : "false");")
    }
    
    func conditions(_ conditions: [(variable: WebVariable, operator: Operator)]) {
        for condition in conditions {
            let instanceId = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
            executionPipeline()?.context?.builderScript("""
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
    
    func condition(_ variable: WebVariable, operator: Operator) {
        
        executionPipeline()?.context?.builderScript("""
var testCondition\(builderId) = function() {
    if(\(variable.builderId) \(`operator`.javascriptCondition)) { \(builderId) = true; } else { \(builderId) = false; }
};
let condition\(builderId) = setInterval(testCondition\(builderId), 500);
""")
        
    }
    func set(_ value: Bool) {
        internalValue = value
        executionPipeline()?.context?.script("\(builderId) = \(internalValue == true ? "true" : "false");")
    }
    func toggle() {
        internalValue = !internalValue
        executionPipeline()?.context?.script("\(builderId) = \(internalValue == true ? "true" : "false");")
    }
}

public class WString : WebVariable {
    
    internal var internalValue: String = "" {
        didSet {
            executionPipeline()?.context?.builderScript("\(builderId) = '\(internalValue)'")
        }
    }
    
    init(_ value: String) {
        super.init()
        internalValue = value
        executionPipeline()?.context?.builderScript("var \(builderId) = '\(value)';")
    }
    
    static func +(lhs: WString, rhs: WString) -> WString {
        return WString(lhs.internalValue + rhs.internalValue)
    }
    
    static func ==(lhs: WString, rhs: WString) -> Bool {
        return lhs.internalValue == rhs.internalValue
    }
    
    static func !=(lhs: WString, rhs: WString) -> Bool {
        return lhs.internalValue != rhs.internalValue
    }
    
    static func +=(lhs: inout WString, rhs: WString) {
        lhs.internalValue.append(rhs.internalValue)
    }
    
    static func ==(lhs: WString, rhs: String) -> Bool {
        return lhs.internalValue == rhs
    }
    
    static func ==(lhs: String, rhs: WString) -> Bool {
        return lhs == rhs.internalValue
    }
    
}

public class WebVariable : WebCommonInterop {
    
    var formName: String? = nil
    
    func name(_ name: String) -> Self {
        formName = name
        executionPipeline()?.context?.builderScript("\(builderId).name = '\(name)';")
        return self
    }
    
    func onValueChange(_ actions: [WebAction]) -> Self {
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
