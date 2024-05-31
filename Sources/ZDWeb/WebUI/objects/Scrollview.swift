//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public enum ScrollDirections {
    case vertical
    case horizontal
    case both
}

public class Scrollview : WebElement {
    @discardableResult
    public init(direction: ScrollDirections? = .horizontal, body: WebComposerClosure) {
        
        super.init()
        
        executionPipeline()?.context?.declarative("div", identifier: self.builderId , {
            // now build the body of the picker
            body()
        })
        
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        
        if let direction = direction {
            switch direction {
            case .vertical:
                executionPipeline()?.context?.builderScript("\(builderId).style.overflowY = 'scroll';")
                executionPipeline()?.context?.builderScript("\(builderId).style.whiteSpace = 'nowrap';")
            case .horizontal:
                executionPipeline()?.context?.builderScript("\(builderId).style.overflowX = 'scroll';")
                executionPipeline()?.context?.builderScript("\(builderId).style.whiteSpace = 'nowrap';")
            case .both:
                executionPipeline()?.context?.builderScript("\(builderId).style.overflowY = 'scroll';")
                executionPipeline()?.context?.builderScript("\(builderId).style.overflowX = 'scroll';")
                executionPipeline()?.context?.builderScript("\(builderId).style.whiteSpace = 'nowrap';")
            }
        }
    }
}
