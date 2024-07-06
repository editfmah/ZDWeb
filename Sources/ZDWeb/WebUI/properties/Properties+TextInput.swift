//
//  Properties+TextEditor.swift
//
//
//  Created by Adrian Herridge on 06/07/2024.
//

import Foundation

extension GenericTextInputProperties {
        
        @discardableResult
        public func placeholder(_ placeholder: String) -> Self {
            executionPipeline()?.context?.builderScript("\(builderId).placeholder = '\(placeholder)';")
            return self
        }
        
        @discardableResult
        public func rows(_ rows: Int) -> Self {
            executionPipeline()?.context?.builderScript("\(builderId).rows = \(rows);")
            return self
        }
        
        @discardableResult
        public func cols(_ cols: Int) -> Self {
            executionPipeline()?.context?.builderScript("\(builderId).cols = \(cols);")
            return self
        }
        
        @discardableResult
        public func readonly(_ readonly: WBool) -> Self {
            executionPipeline()?.context?.builderScript("\(builderId).readOnly = \(readonly.internalValue ? "true" : "false");")
            return self
        }
        
        @discardableResult
        public func readonly(_ variable: WebVariable,_ operator: Operator) -> Self {
            executionPipeline()?.context?.builderScript("if(\(variable.builderId) \(`operator`.javascriptCondition)) { \(builderId).readOnly = true; }")
            return self
        }
        
        @discardableResult
        public func required(_ required: WBool) -> Self {
            executionPipeline()?.context?.builderScript("\(builderId).required = \(required.internalValue ? "true" : "false");")
            return self
        }
        
        @discardableResult
        public func required(_ variable: WebVariable,_ operator: Operator) -> Self {
            executionPipeline()?.context?.builderScript("if(\(variable.builderId) \(`operator`.javascriptCondition)) { \(builderId).required = true; }")
            return self
        }
        
        @discardableResult
        public func maxlength(_ length: Int) -> Self {
            executionPipeline()?.context?.builderScript("\(builderId).maxLength = \(length);")
            return self
        }
        
        @discardableResult
        public func minlength(_ length: Int) -> Self {
            executionPipeline()?.context?.builderScript("\(builderId).minLength = \(length);")
            return self
        }
}
