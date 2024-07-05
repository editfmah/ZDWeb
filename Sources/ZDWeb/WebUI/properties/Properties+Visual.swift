//
//  File.swift
//
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation
public extension GenericProperties {
    @discardableResult
    func opacity(_ opacity: Double) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.opacity = '\(opacity)';")
        return self
    }
    @discardableResult
    func hidden(_ hidden: WBool) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).hidden = \(hidden.internalValue ? "true" : "false");")
        executionPipeline()?.context?.builderScript("""
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
        
        executionPipeline()?.context?.builderScript("""
// condition tester and publisher
var hiddenTestCondition\(builderId) = function() {
if(\(variable.builderId) \(`operator`.javascriptCondition)) { \(builderId).style.display = 'none'; } else { \(builderId).style.display = 'initial'; }
};
let hiddenCondition\(builderId) = setInterval(hiddenTestCondition\(builderId), 500);
""")

        return self
    }
    @discardableResult
    func enabled(_ enabled: WBool) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).hidden = \(enabled.internalValue ? "true" : "false");")
        executionPipeline()?.context?.builderScript("""
function \(builderId)EnabledInterval() {
    if (\(enabled.builderId) == true) {
        \(builderId).disabled = false;
    } else {
        \(builderId).disabled = true;
    }
}
let \(builderId)HiddenEnabledTimer = setInterval(\(builderId)EnabledInterval, 500);
""")
        return self
    }
    @discardableResult
    func enabled(_ variable: WebVariable,_ operator: Operator) -> Self {
        
        executionPipeline()?.context?.builderScript("""
// condition tester and publisher
var enabledTestCondition\(builderId) = function() {
if(\(variable.builderId) \(`operator`.javascriptCondition)) { \(builderId).disabled = false; } else { \(builderId).disabled = true; }
};
let enabledCondition\(builderId) = setInterval(enabledTestCondition\(builderId), 500);
""")

        return self
    }
    @discardableResult
    func clip() -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.clipPath = 'border-box';")
        return self
    }
    @discardableResult
    func position(_ position: WebPosition) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.position = '\(position.rawValue)';")
        return self
    }
}
