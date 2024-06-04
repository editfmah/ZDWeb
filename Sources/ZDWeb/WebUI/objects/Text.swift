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
        executionPipeline()?.types[self.builderId] = .text
        if executionPipeline()?.withinPickerBuilder == false {
            executionPipeline()?.context?.declarative("span", identifier: self.builderId , {
                
            })
            executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            executionPipeline()?.context?.builderScript("\(builderId).innerText = '\(text)';")
        } else {
            executionPipeline()?.context?.declarative("option", identifier: self.builderId , {
                
            })
            executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
            executionPipeline()?.context?.builderScript("\(builderId).innerText = '\(text)';")
        }
        addClass("col")
    }
    public init(_ binding: WString) {
        
        super.init()
        executionPipeline()?.types[self.builderId] = .text
        executionPipeline()?.context?.declarative("span", identifier: self.builderId , {
            
        })
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        executionPipeline()?.context?.builderScript("\(builderId).innerText = '\(binding.internalValue)';")
        
        // now lets listen for changes from the bound object
        executionPipeline()?.context?.builderScript("""
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
