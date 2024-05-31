//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class Toggle : WebElement {
    @discardableResult
    public init(binding: WBool? = nil) {
        /*
         <div class="form-check">
          <input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
          <label class="form-check-label">Option 1</label>
        </div>
         */
        super.init()
        executionPipeline()?.context?.declarative("input", identifier: self.builderId , {
            
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("form-check-input")
        addClass("form-control")
        executionPipeline()?.context?.builderScript("\(builderId).type = 'checkbox';")
        if let binding = binding {
            
            // initial value
            if binding.internalValue {
                executionPipeline()?.context?.builderScript("\(builderId).checked = true;")
            } else {
                executionPipeline()?.context?.builderScript("\(builderId).checked = false;")
            }
            
            // monitor for checkbox changes
            executionPipeline()?.context?.builderScript("""
\(builderId).addEventListener('input', function() {
    \(binding.builderId) = \(builderId).checked;
});
\(builderId).value = \(binding.builderId);
l\(self.builderId)();
function l\(self.builderId)() {
  const rl\(self.builderId) = () => {
    \(builderId).checked = \(binding.builderId);
    return setTimeout(rl\(self.builderId), 500);
  };
  rl\(self.builderId)();
}
""")
        }
        
    }
}
