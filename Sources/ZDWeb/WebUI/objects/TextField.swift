//
//  File.swift
//
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class TextField : WebElement {
    @discardableResult
    public init(_ placeholder: String, name: String? = nil, binding: WString? = nil) {
        super.init()
        declare("input", classList: self.builderId , {
            
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
    \(builderId).innerText = \(binding.builderId);
    return setTimeout(rl\(self.builderId), 500);
  };
  rl\(self.builderId)();
}
""")
        }
        
    }
}
