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
        
        executingWebThread?.declarative("div", identifier: self.builderId , {
            // now build the body of the picker
            body()
        })
        
        executingWebThread?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        
        if let direction = direction {
            switch direction {
            case .vertical:
                executingWebThread?.builderScript("\(builderId).style.overflowY = 'scroll';")
                executingWebThread?.builderScript("\(builderId).style.whiteSpace = 'nowrap';")
            case .horizontal:
                executingWebThread?.builderScript("\(builderId).style.overflowX = 'scroll';")
                executingWebThread?.builderScript("\(builderId).style.whiteSpace = 'nowrap';")
            case .both:
                executingWebThread?.builderScript("\(builderId).style.overflowY = 'scroll';")
                executingWebThread?.builderScript("\(builderId).style.overflowX = 'scroll';")
                executingWebThread?.builderScript("\(builderId).style.whiteSpace = 'nowrap';")
            }
        }
    }
}
