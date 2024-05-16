//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class WebCommonInterop {
    
    public  var builderId = UUID()
        .uuidString
        .replacingOccurrences(of: "-", with: "")
        .trimmingCharacters(in: CharacterSet.decimalDigits).prefix(8).lowercased()
    
    func addClass(_ cls: String) {
        executingWebThread?.builderScript("\(builderId).classList.add('\(cls)');")
    }
    
}

public class WebElement : WebCommonInterop, GenericProperties {
    
    
}

public class WebImageElement : WebCommonInterop, ImageProperties {
    
}

