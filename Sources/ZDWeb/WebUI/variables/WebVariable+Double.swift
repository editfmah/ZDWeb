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
    
    public init(_ value: Double) {
        super.init()
        internalValue = value
        script("/* builder-object-reference */ var \(builderId) = \(value);")
    }
    
    public static func +(lhs: WDouble, rhs: WDouble) -> WDouble {
        return WDouble(lhs.internalValue + rhs.internalValue)
    }
    
    public static func -(lhs: WDouble, rhs: WDouble) -> WDouble {
        return WDouble(lhs.internalValue - rhs.internalValue)
    }
    
    public static func *(lhs: WDouble, rhs: WDouble) -> WDouble {
        return WDouble(lhs.internalValue * rhs.internalValue)
    }
    
    public static func /(lhs: WDouble, rhs: WDouble) -> WDouble {
        return WDouble(lhs.internalValue / rhs.internalValue)
    }
    
    public static func ==(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue == rhs.internalValue
    }
    
    public static func !=(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue != rhs.internalValue
    }
    
    public static func +=(lhs: inout WDouble, rhs: WDouble) {
        lhs.internalValue += rhs.internalValue
    }
    
    public static func -=(lhs: inout WDouble, rhs: WDouble) {
        lhs.internalValue -= rhs.internalValue
    }
    
    public static func *=(lhs: inout WDouble, rhs: WDouble) {
        lhs.internalValue *= rhs.internalValue
    }
    
    public static func /=(lhs: inout WDouble, rhs: WDouble) {
        lhs.internalValue /= rhs.internalValue
    }
    
    public static func ==(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue == rhs
    }
    
    public static func ==(lhs: Double, rhs: WDouble) -> Bool {
        return lhs == rhs.internalValue
    }
    
    public static func !=(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue != rhs
    }
    
    public static func >(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue > rhs.internalValue
    }
    
    public static func <(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue < rhs.internalValue
    }
    
    public static func >=(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue >= rhs.internalValue
    }
    
    public static func <=(lhs: WDouble, rhs: WDouble) -> Bool {
        return lhs.internalValue <= rhs.internalValue
    }
    
    public static func >(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue > rhs
    }
    
    public static func <(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue < rhs
    }
    
    public static func >=(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue >= rhs
    }
    
    public static func <=(lhs: WDouble, rhs: Double) -> Bool {
        return lhs.internalValue <= rhs
    }
    
    public static func >(lhs: Double, rhs: WDouble) -> Bool {
        return lhs > rhs.internalValue
    }
    
    public static func <(lhs: Double, rhs: WDouble) -> Bool {
        return lhs < rhs.internalValue
    }
    
    public static func >=(lhs: Double, rhs: WDouble) -> Bool {
        return lhs >= rhs.internalValue
    }
    
    public static func <=(lhs: Double, rhs: WDouble) -> Bool {
        return lhs <= rhs.internalValue
    }
    
}
