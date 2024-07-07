//
//  TextEditor.swift
//  
//
//  Created by Adrian Herridge on 06/07/2024.
//

import Foundation

public class TextEditor : WebTextInputElement {
    @discardableResult
    public init(_ placeholder: String, name: String? = nil, binding: WString? = nil) {
        super.init()
        declare("textarea", identifier: self.builderId , {
            
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        script("\(builderId).placeholder = '\(placeholder)';")
        addClass("form-control")
        
        if let binding = binding {
            script("""
\(builderId).addEventListener('input', function() {
    \(binding.builderId) = \(builderId).value;
});
\(builderId).value = \(binding.builderId);
l\(self.builderId)();
function l\(self.builderId)() {
  const rl\(self.builderId) = () => {
    \(builderId).value = \(binding.builderId);
    return setTimeout(rl\(self.builderId), 500);
  };
  rl\(self.builderId)();
}
""")
        }
        
    }
}
