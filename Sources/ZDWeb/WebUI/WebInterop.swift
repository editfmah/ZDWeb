//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

class WebCommonInterop {
    
    internal var builderId = UUID()
        .uuidString
        .replacingOccurrences(of: "-", with: "")
        .trimmingCharacters(in: CharacterSet.decimalDigits).prefix(8).lowercased()
    
    internal func addClass(_ cls: String) {
        executingWebThread?.builderScript("\(builderId).classList.add('\(cls)');")
    }
    
}

class WebElement : WebCommonInterop, GenericProperties {
    
    
}

class WebImageElement : WebCommonInterop, ImageProperties {
    
}

