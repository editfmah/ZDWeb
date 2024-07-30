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
        
        declare("div", classList: self.builderId , {
            // now build the body of the picker
            body()
        })
        
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        
        addClass("d-flex")
        
        if let direction = direction {
            switch direction {
            case .vertical:
                script("\(builderId).style.overflowY = 'scroll';")
                script("\(builderId).style.whiteSpace = 'nowrap';")
            case .horizontal:
                script("\(builderId).style.overflowX = 'scroll';")
                script("\(builderId).style.whiteSpace = 'nowrap';")
            case .both:
                script("\(builderId).style.overflowY = 'scroll';")
                script("\(builderId).style.overflowX = 'scroll';")
                script("\(builderId).style.whiteSpace = 'nowrap';")
            }
        }
    }
}
