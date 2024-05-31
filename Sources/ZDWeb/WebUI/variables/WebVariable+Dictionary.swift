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
    
    init(_ value: [String:String]) {
        super.init()
        internalValue = value
        executionPipeline()?.context?.builderScript("var \(builderId) = \(value);")
    }
    
    static func +(lhs: WDictionary, rhs: WDictionary) -> WDictionary {
        var newDict = lhs.internalValue
        for (key, value) in rhs.internalValue {
            newDict[key] = value
        }
        return WDictionary(newDict)
    }
    
    static func -(lhs: WDictionary, rhs: WDictionary) -> WDictionary {
        var newDict = lhs.internalValue
        for (key, _) in rhs.internalValue {
            newDict.removeValue(forKey: key)
        }
        return WDictionary(newDict)
    }
    
    static func ==(lhs: WDictionary, rhs: WDictionary) -> Bool {
        return lhs.internalValue == rhs.internalValue
    }
    
    static func !=(lhs: WDictionary, rhs: WDictionary) -> Bool {
        return lhs.internalValue != rhs.internalValue
    }
    
    static func +=(lhs: inout WDictionary, rhs: WDictionary) {
        for (key, value) in rhs.internalValue {
            lhs.internalValue[key] = value
        }
    }
    
    static func -=(lhs: inout WDictionary, rhs: WDictionary) {
        for (key, _) in rhs.internalValue {
            lhs.internalValue.removeValue(forKey: key)
        }
    }
    
}
