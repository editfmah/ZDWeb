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
        .trimmingCharacters(in: CharacterSet.decimalDigits)
        .prefix(12)
        .lowercased()
    
    public var ref: String? = nil
    
    func addClass(_ cls: String) {
        executionPipeline()?.context?.builderScript("\(builderId).classList.add('\(cls)');")
    }
    
}

public class WebElement : WebCommonInterop, GenericProperties {}

public class WebButtonElement : WebCommonInterop, GenericButtonProperties {}

public class WebFormElement : WebCommonInterop, GenericFormProperties {}

public class WebImageElement : WebCommonInterop, ImageProperties {}

