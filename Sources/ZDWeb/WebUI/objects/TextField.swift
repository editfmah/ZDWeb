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
        executionPipeline()?.context?.declarative("input", identifier: self.builderId , {
            
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        executionPipeline()?.context?.builderScript("\(builderId).placeholder = '\(placeholder)';")
        addClass("form-control")
        
        if let binding = binding {
            executionPipeline()?.context?.builderScript("""
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
