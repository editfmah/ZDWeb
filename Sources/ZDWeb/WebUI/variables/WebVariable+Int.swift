//
//  File.swift
//  
//
//  Created by Adrian Herridge on 31/05/2024.
//

import Foundation

public class WInt : WebVariable {
    
    internal var internalValue: Int = 0 {
        didSet {
            executionPipeline()?.context?.builderScript("\(builderId) = \(internalValue);")
        }
    }
    
    public init(_ value: Int) {
        super.init()
        internalValue = value
        executionPipeline()?.context?.builderScript("var \(builderId) = \(value);")
    }
    
    static func +(lhs: WInt, rhs: WInt) -> WInt {
        return WInt(lhs.internalValue + rhs.internalValue)
    }
    
    static func -(lhs: WInt, rhs: WInt) -> WInt {
        return WInt(lhs.internalValue - rhs.internalValue)
    }
    
    static func *(lhs: WInt, rhs: WInt) -> WInt {
        return WInt(lhs.internalValue * rhs.internalValue)
    }
    
    static func /(lhs: WInt, rhs: WInt) -> WInt {
        return WInt(lhs.internalValue / rhs.internalValue)
    }
    
    static func %(lhs: WInt, rhs: WInt) -> WInt {
        return WInt(lhs.internalValue % rhs.internalValue)
    }
    
    static func +=(lhs: inout WInt, rhs: WInt) {
        lhs.internalValue += rhs.internalValue
    }
    
    static func -=(lhs: inout WInt, rhs: WInt) {
        lhs.internalValue -= rhs.internalValue
    }
    
    static func *=(lhs: inout WInt, rhs: WInt) {
        lhs.internalValue *= rhs.internalValue
    }
    
    static func /=(lhs: inout WInt, rhs: WInt) {
        lhs.internalValue /= rhs.internalValue
    }
    
    static func %=(lhs: inout WInt, rhs: WInt) {
        lhs.internalValue %= rhs.internalValue
    }
    
    static func ==(lhs: WInt, rhs: WInt) -> Bool {
        return lhs.internalValue == rhs.internalValue
    }
    
    static func !=(lhs: WInt, rhs: WInt) -> Bool {
        return lhs.internalValue != rhs.internalValue
    }
    
    static func >(lhs: WInt, rhs: WInt) -> Bool {
        return lhs.internalValue > rhs.internalValue
    }
    
    static func <(lhs: WInt, rhs: WInt) -> Bool {
        return lhs.internalValue < rhs.internalValue
    }
    
}
