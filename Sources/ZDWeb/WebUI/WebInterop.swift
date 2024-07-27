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
    
    public func addClass(_ cls: String) {
        executionPipeline()?.context?.builderScript("\(builderId).classList.add('\(cls)');")
    }
    
    public var pipeline: WebRequestExecutionPipeline {
        return executionPipeline()!
    }
    
    public var context: WebRequestContext {
        return pipeline.context!
    }
    
    public func script(_ script: String) {
        context.builderScript(script)
    }
    
    public func declare(_ tag: String, identifier: String, id: String? = nil, type: String? = nil, for: String? = nil, name: String? = nil, attributes: [String:String]? = nil, _ body: WebComposerClosure) {
        context.declarative(tag, identifier: identifier, id: id, type: type, for: `for`, name: name, attributes: attributes, body)
    }
    
    public var type: WebElementType {
        get {
            return pipeline.types[builderId] ?? .unknown
        }
        set {
            pipeline.types[builderId] = newValue
        }
    }
    
    public var isPicker: Bool {
        get {
            return pipeline.withinPickerBuilder
        }
        set {
            pipeline.withinPickerBuilder = newValue
        }
    }
    
    public var pickerType: PickerType {
        get {
            return pipeline.pickerType
        }
        set {
            pipeline.pickerType = newValue
        }
    }
    
}

public class WebTextInputElement : WebCommonInterop, GenericTextInputProperties {}

public class WebElement : WebCommonInterop, GenericProperties {}

public class WebTableElement : WebCommonInterop, GenericTableProperties {}

public class WebButtonElement : WebCommonInterop, GenericButtonProperties {}

public class WebFormElement : WebCommonInterop, GenericFormProperties {}

public class WebImageElement : WebCommonInterop, ImageProperties {}

