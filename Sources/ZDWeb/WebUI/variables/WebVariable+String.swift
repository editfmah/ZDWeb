//
//  File.swift
//  
//
//  Created by Adrian Herridge on 31/05/2024.
//

import Foundation

public class WString : WebVariable {
    
    internal var internalValue: String = "" {
        didSet {
            executionPipeline()?.context?.builderScript("\(builderId) = '\(internalValue)'")
        }
    }
    
    public init(_ value: String) {
        super.init()
        internalValue = value
        executionPipeline()?.context?.builderScript("var \(builderId) = '\(value)';")
    }
    
    public static func +(lhs: WString, rhs: WString) -> WString {
        return WString(lhs.internalValue + rhs.internalValue)
    }
    
    public static func ==(lhs: WString, rhs: WString) -> Bool {
        return lhs.internalValue == rhs.internalValue
    }
    
    public static func !=(lhs: WString, rhs: WString) -> Bool {
        return lhs.internalValue != rhs.internalValue
    }
    
    public static func +=(lhs: inout WString, rhs: WString) {
        lhs.internalValue.append(rhs.internalValue)
    }
    
    public static func ==(lhs: WString, rhs: String) -> Bool {
        return lhs.internalValue == rhs
    }
    
    public static func ==(lhs: String, rhs: WString) -> Bool {
        return lhs == rhs.internalValue
    }
    
}
