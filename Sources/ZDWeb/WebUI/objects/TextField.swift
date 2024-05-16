//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class TextField : WebElement {
    @discardableResult
    init(_ placeholder: String, binding: WString? = nil) {
        super.init()
        executingWebThread?.declarative("input", identifier: self.builderId , {
            
        })
        executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        executingWebThread?.builderScript("\(builderId).placeholder = '\(placeholder)';")
        addClass("form-control")
        
        if let binding = binding {
            executingWebThread?.builderScript("""
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
