//
//  File.swift
//  
//
//  Created by Adrian Herridge on 31/05/2024.
//

import Foundation

public class WDouble : WebVariable {
    
    internal var internalValue: Double = 0.0 {
        didSet {
            executionPipeline()?.context?.builderScript("\(builderId) = \(internalValue)")
        }
    }
    
    init(_ value: Double) {
        super.init()
        internalValue = value
        executionPipeline()?.context?.builderScript("var \(builderId) = \(value);")
    }
    
    static func +(lhs: WDouble, rhs: WDouble) -> WDouble {
        return WDouble(lhs.internalValue + rhs.internalValue)
    }
    
    static func -(lhs: WDouble, rhs: WDouble) -> WDouble {
        return WDouble(lhs.internalValue - rhs.internalValue)
    }
    
    static func *(lhs: WDouble, rhs: WDouble) -> WDouble {
        return WDouble(lhs.internalValue * rhs.internalValue)
    }
    
    static func /(lhs: WDouble, rhs: WDouble) -> WDouble {
        return WDouble(lhs.internalValue / rhs.internalValue)
    }
    
    static func ==(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue == rhs.internalValue
    }
    
    static func !=(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue != rhs.internalValue
    }
    
    static func +=(lhs: inout WDouble, rhs: WDouble) {
        lhs.internalValue += rhs.internalValue
    }
    
    static func -=(lhs: inout WDouble, rhs: WDouble) {
        lhs.internalValue -= rhs.internalValue
    }
    
    static func *=(lhs: inout WDouble, rhs: WDouble) {
        lhs.internalValue *= rhs.internalValue
    }
    
    static func /=(lhs: inout WDouble, rhs: WDouble) {
        lhs.internalValue /= rhs.internalValue
    }
    
    static func ==(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue == rhs
    }
    
    static func ==(lhs: Double, rhs: WDouble) -> Bool {
        return lhs == rhs.internalValue
    }
    
    static func !=(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue != rhs
    }
    
    static func >(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue > rhs.internalValue
    }
    
    static func <(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue < rhs.internalValue
    }
    
    static func >=(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue >= rhs.internalValue
    }
    
    static func <=(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue <= rhs.internalValue
    }
    
    static func >(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue > rhs
    }
    
    static func <(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue < rhs
    }
    
    static func >=(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue >= rhs
    }
    
    static func <=(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue <= rhs
    }
    
    static func >(lhs: Double, rhs: WDouble) -> Bool {
        return lhs > rhs.internalValue
    }
    
    static func <(lhs: Double, rhs: WDouble) -> Bool {
        return lhs < rhs.internalValue
    }
    
    static func >=(lhs: Double, rhs: WDouble) -> Bool {
        return lhs >= rhs.internalValue
    }
    
    static func <=(lhs: Double, rhs: WDouble) -> Bool {
        return lhs <= rhs.internalValue
    }
    
}
