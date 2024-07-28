//
//  File.swift
//
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class Text : WebElement {
    @discardableResult
    public init(_ text: String) {
        super.init()
        type = .text
        if isPicker == false {
            declare("span", identifier: self.builderId , {
                context.text(text)
            })
        } else {
            switch pickerType {
            case .dropdown:
                declare("option", identifier: self.builderId , {
                    context.text(text)
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
                // these are actually buttons, within a button group
                // <button type="button" class="btn btn-secondary">Left</button>
                declare("button", identifier: self.builderId + " btn btn-secondary" , {
                    context.text(text)
                })
            }
        }
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        if isPicker && pickerType == .segmented {
            // set the type to button
            script("\(builderId).type = 'button';")
        }
        addClass("col")
    }
    @discardableResult
    public init(_ binding: WString) {
        
        super.init()
        type = .text
        declare("span", identifier: self.builderId , {
            
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        script("\(builderId).innerText = '\(binding.internalValue)';")
        
        // now lets listen for changes from the bound object
        script("""
l\(self.builderId)();
function l\(self.builderId)() {
  const rl\(self.builderId) = () => {
    \(builderId).innerText = \(binding.builderId);
    return setTimeout(rl\(self.builderId), 500);
  };
  rl\(self.builderId)();
}
""")
        addClass("col")
    }
}
