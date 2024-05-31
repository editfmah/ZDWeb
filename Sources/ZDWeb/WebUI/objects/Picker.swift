//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public enum PickerType {
    case dropdown
    case radio
    case check
    case modal
    case view
}

public class Picker : WebElement {
    @discardableResult
    public init(type: PickerType? = .dropdown, binding: WString? = nil, body: WebComposerClosure) {
        super.init()
        executionPipeline()?.context?.declarative("select", identifier: self.builderId , {
            // now build the body of the picker
            executionPipeline()?.withinPickerBuilder = true
            executionPipeline()?.pickers[self.builderId] = type
            body()
            executionPipeline()?.withinPickerBuilder = false
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("form-select")
        addClass("form-control")
        if let binding = binding {
            executionPipeline()?.context?.builderScript("""
\(builderId).addEventListener('input', function() {
    \(binding.builderId) = \(builderId).value;
});
\(binding.builderId) = \(builderId).value;
""")
        }
    }
}
