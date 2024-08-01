//
//  File.swift
//  
//
//  Created by Adrian Herridge on 31/05/2024.
//

import Foundation

// this object is a dictionary of string to string values [String:String]
public class WDictionary : WebVariable {
    
    internal var internalValue: [String:String] = [:] {
        didSet {
            executionPipeline()?.context?.builderScript("\(builderId) = \(internalValue)")
        }
    }
    
    public init(_ value: [String:String]) {
        super.init()
        internalValue = value
        script("/* builder-object-reference */ var \(builderId) = \(value);")
    }
    
    public static func +(lhs: WDictionary, rhs: WDictionary) -> WDictionary {
        var newDict = lhs.internalValue
        for (key, value) in rhs.internalValue {
            newDict[key] = value
        }
        return WDictionary(newDict)
    }
    
    public static func -(lhs: WDictionary, rhs: WDictionary) -> WDictionary {
        var newDict = lhs.internalValue
        for (key, _) in rhs.internalValue {
            newDict.removeValue(forKey: key)
        }
        return WDictionary(newDict)
    }
    
    public static func ==(lhs: WDictionary, rhs: WDictionary) -> Bool {
        return lhs.internalValue == rhs.internalValue
    }
    
    public static func !=(lhs: WDictionary, rhs: WDictionary) -> Bool {
        return lhs.internalValue != rhs.internalValue
    }
    
    public static func +=(lhs: inout WDictionary, rhs: WDictionary) {
        for (key, value) in rhs.internalValue {
            lhs.internalValue[key] = value
        }
    }
    
    public static func -=(lhs: inout WDictionary, rhs: WDictionary) {
        for (key, _) in rhs.internalValue {
            lhs.internalValue.removeValue(forKey: key)
        }
    }
    
}
