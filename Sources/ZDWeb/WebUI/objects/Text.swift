//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class Text : WebElement {
    @discardableResult
    init(_ text: String) {
        super.init()
        if withinPickerBuilder == false {
            executingWebThread?.declarative("p", identifier: self.builderId , {
                
            })
            executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            executingWebThread?.builderScript("\(builderId).innerText = '\(text)';")
        } else {
            executingWebThread?.declarative("option", identifier: self.builderId , {
                
            })
            executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            executingWebThread?.builderScript("\(builderId).innerText = '\(text)';")
        }
        addClass("col-md-auto")
    }
    init(_ binding: WString) {
        
        super.init()
        
        executingWebThread?.declarative("p", identifier: self.builderId , {
            
        })
        executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        executingWebThread?.builderScript("\(builderId).innerText = '\(binding.internalValue)';")
        
        // now lets listen for changes from the bound object
        executingWebThread?.builderScript("""
l\(self.builderId)();
function l\(self.builderId)() {
  const rl\(self.builderId) = () => {
    \(builderId).innerText = \(binding.builderId);
    return setTimeout(rl\(self.builderId), 500);
  };
  rl\(self.builderId)();
}
""")
        addClass("col-md-auto")
    }
}
