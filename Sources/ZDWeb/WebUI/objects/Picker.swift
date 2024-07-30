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
    case segmented
}

public class Picker : WebElement {
    @discardableResult
    public init(type: PickerType? = .dropdown, binding: WString? = nil, body: WebComposerClosure) {
        
        super.init()
        pipeline.metadata["binding"] = binding
        isPicker = true
        if let type = type {
            pickerType = type
            
            switch type {
            case .dropdown:
                declare("select", classList: self.builderId , {
                    body()
                })
                script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
                addClass("form-select")
                addClass("form-control")
            case .radio:
                break;
            case .check:
                break;
            case .modal:
                break;
            case .view:
                break;
            case .segmented:
                body()
            }
            
            if [.dropdown].contains(type) {
                if let binding = binding {
                    script("""

        // get the selected value form the bound variable
        var \(builderId)Current = \(binding.builderId);

        // now go through the picker and mark the correct value as selected.  This could be a dropdown, radio, check or modal
        var \(builderId)Options = \(builderId).getElementsByTagName('option');
        for (var i = 0; i < \(builderId)Options.length; i++) {
            if (\(builderId)Options[i].value == \(builderId)Current) {
                \(builderId)Options[i].selected = true;
            }
        }

        \(builderId).addEventListener('input', function() {
            \(binding.builderId) = \(builderId).value;
        });
        \(binding.builderId) = \(builderId).value;
        """)
                }
            }
            
        }
        isPicker = false
        pipeline.metadata = [:]
        

    }
}
