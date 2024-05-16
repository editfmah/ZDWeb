//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class Toggle : WebElement {
    @discardableResult
    init(binding: WBool? = nil) {
        /*
         <div class="form-check">
          <input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
          <label class="form-check-label">Option 1</label>
        </div>
         */
        super.init()
        executingWebThread?.declarative("input", identifier: self.builderId , {
            
        })
        executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("form-check-input")
        executingWebThread?.builderScript("\(builderId).type = 'checkbox';")
        if let binding = binding {
            
            // initial value
            if binding.internalValue {
                executingWebThread?.builderScript("\(builderId).checked = true;")
            } else {
                executingWebThread?.builderScript("\(builderId).checked = false;")
            }
            
            // monitor for checkbox changes
            executingWebThread?.builderScript("""
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
