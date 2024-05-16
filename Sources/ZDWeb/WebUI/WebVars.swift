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
            executingWebThread?.builderScript("\(builderId) = \(internalValue == true ? "true" : "false");")
        }
    }
    
    init(_ value: Bool) {
        super.init()
        internalValue = value
        executingWebThread?.builderScript("var \(builderId) = \(internalValue == true ? "true" : "false");")
    }
    
    func condition(_ variable: WebVariable, operator: Operator) {
        switch `operator` {
        case .equals(let value):
            executingWebThread?.builderScript("""
// condition tester and publisher
var testCondition\(builderId) = function() {
    if(\(variable.builderId) == \(value)) { \(builderId) = true; } else { \(builderId) = false; }
};
let condition\(builderId) = setInterval(testCondition\(builderId), 500);
""")
        case .isEmpty:
            executingWebThread?.builderScript("""
// condition tester and publisher
var testCondition\(builderId) = function() {
    if(\(variable.builderId) == '') { \(builderId) = true; } else { \(builderId) = false; }
};
let condition\(builderId) = setInterval(testCondition\(builderId), 500);
""")
        case .isNotEmpty:
            executingWebThread?.builderScript("""
// condition tester and publisher
var testCondition\(builderId) = function() {
    if(\(variable.builderId) != '') { \(builderId) = true; } else { \(builderId) = false; }
};
let condition\(builderId) = setInterval(testCondition\(builderId), 500);
""")
        case .isTrue:
            executingWebThread?.builderScript("""
// condition tester and publisher
var testCondition\(builderId) = function() {
    if(\(variable.builderId) == true) { \(builderId) = true; } else { \(builderId) = false; }
};
let condition\(builderId) = setInterval(testCondition\(builderId), 500);
""")
        case .isFalse:
            executingWebThread?.builderScript("""
// condition tester and publisher
var testCondition\(builderId) = function() {
    if(\(variable.builderId) == false) { \(builderId) = true; } else { \(builderId) = false; }
};
let condition\(builderId) = setInterval(testCondition\(builderId), 500);
""")
        }
    }
    func set(_ value: Bool) {
        internalValue = value
        executingWebThread?.script("\(builderId) = \(internalValue == true ? "true" : "false");")
    }
    func toggle() {
        internalValue = !internalValue
        executingWebThread?.script("\(builderId) = \(internalValue == true ? "true" : "false");")
    }
}

public class WString : WebVariable {
    
    internal var internalValue: String = "" {
        didSet {
            executingWebThread?.builderScript("\(builderId) = '\(internalValue)'")
        }
    }
    
    init(_ value: String) {
        super.init()
        internalValue = value
        executingWebThread?.builderScript("var \(builderId) = '\(value)'")
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
    
}
