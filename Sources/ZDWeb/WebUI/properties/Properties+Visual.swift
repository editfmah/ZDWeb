//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation
extension GenericProperties {
    @discardableResult
    func opacity(_ opacity: Double) -> Self {
        executingWebThread?.builderScript("\(builderId).style.opacity = '\(opacity)';")
        return self
    }
    @discardableResult
    func hidden(_ hidden: WBool) -> Self {
        executingWebThread?.builderScript("\(builderId).hidden = \(hidden.internalValue ? "true" : "false");")
        executingWebThread?.builderScript("""
function \(builderId)HiddenInterval() {
    if (\(hidden.builderId) == true) {
        \(builderId).style.display = 'none';
    } else {
        \(builderId).style.display = 'initial';
    }
}
let \(builderId)HiddenIntervalTimer = setInterval(\(builderId)HiddenInterval, 500);
""")
        return self
    }
    @discardableResult
    func hidden(_ variable: WebVariable,_ operator: Operator) -> Self {
        switch `operator` {
        case .equals(let value):
            executingWebThread?.builderScript("""
// condition tester and publisher
var hiddenTestCondition\(builderId) = function() {
    if(\(variable.builderId) == \(value)) { \(builderId).style.display = 'none'; } else { \(builderId).style.display = 'initial'; }
};
let hiddenCondition\(builderId) = setInterval(hiddenTestCondition\(builderId), 500);
""")
        case .isEmpty:
            executingWebThread?.builderScript("""
// condition tester and publisher
var hiddenTestCondition\(builderId) = function() {
    if(\(variable.builderId) == '') { \(builderId).style.display = 'none'; } else { \(builderId).style.display = 'initial'; }
};
let hiddenCondition\(builderId) = setInterval(hiddenTestCondition\(builderId), 500);
""")
        case .isNotEmpty:
            executingWebThread?.builderScript("""
// condition tester and publisher
var hiddenTestCondition\(builderId) = function() {
    if(\(variable.builderId) != '') { \(builderId).style.display = 'none'; } else { \(builderId).style.display = 'initial'; }
};
let hiddenCondition\(builderId) = setInterval(hiddenTestCondition\(builderId), 500);
""")
        case .isTrue:
            executingWebThread?.builderScript("""
// condition tester and publisher
var hiddenTestCondition\(builderId) = function() {
    if(\(variable.builderId) == true) { \(builderId).style.display = 'none'; } else { \(builderId).style.display = 'initial'; }
};
let hiddenCondition\(builderId) = setInterval(hiddenTestCondition\(builderId), 500);
""")
        case .isFalse:
            executingWebThread?.builderScript("""
// condition tester and publisher
var hiddenTestCondition\(builderId) = function() {
    if(\(variable.builderId) == false) { \(builderId).style.display = 'none'; } else { \(builderId).style.display = 'initial'; }
};
let hiddenCondition\(builderId) = setInterval(hiddenTestCondition\(builderId), 500);
""")
        }
        return self
    }
}
