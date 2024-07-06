//
//  Option.swift
//
//
//  Created by Adrian Herridge on 06/07/2024.
//

import Foundation

public class Option : WebElement {
    @discardableResult
    public init(_ text: String, value: String? = nil) {
        super.init()
        type = .text
        if isPicker == false {
            declare("span", identifier: self.builderId , {
                
            })
        } else {
            switch pickerType {
            case .dropdown:
                declare("option", identifier: self.builderId , {
                    
                })
            case .radio:
                break;
            case .check:
                break;
            case .modal:
                break;
            case .view:
                break;
            case .segmented:
                
                /*
                 
                 <input type="radio" class="btn-check" name="options-outlined" id="success-outlined" autocomplete="off" checked>
                 <label class="btn btn-outline-success" for="success-outlined">Checked success radio</label>

                 <input type="radio" class="btn-check" name="options-outlined" id="danger-outlined" autocomplete="off">
                 <label class="btn btn-outline-danger" for="danger-outlined">Danger radio</label>
                 
                 */
                
                var name = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
                if let binding = pipeline.metadata["binding"] as? WString, let frmName = binding.formName {
                    name = frmName
                }
                
                let optionId = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
                declare("input", identifier: self.builderId + " btn-check", id: optionId, type: "radio", name: name, attributes: ["autocomplete" : "off"], {
                    
                })
                declare("label", identifier: "btn btn-outline-primary", for: optionId) {
                    context.text(text)
                }
                
                // add an on-click event for this id to set the value of the bound variable
                if let binding = pipeline.metadata["binding"] as? WString, let value = value {
                    script("var \(builderId)_onClick = document.getElementsByClassName('\(builderId)')[0];")
                    script("\(builderId)_onClick.addEventListener('click', function() { \(binding.builderId) = '\(value)'; });")
                }
                
            }
        }
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        if isPicker && pickerType == .dropdown {
            // set the type to button
            script("\(builderId).innerText = '\(text)';")
        }
        addClass("col")
    }
}
