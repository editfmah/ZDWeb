//
//  Properties+Hover.swift
//
//
//  Created by Adrian Herridge on 16/05/2024.
//

import Foundation

public extension GenericProperties {
    @discardableResult
    func hover(_ color: WebColor? = nil, background: WebColor? = nil, bold: Bool? = nil, underline: Bool? = nil) -> Self {
        
        // link-offset-2 link-offset-3-hover link-underline link-underline-opacity-0 link-underline-opacity-75-hover link-underline-opacity-100-hover link-underline-opacity-50-hover link-underline-opacity-25-hover link-underline-opacity-0-hover link-underline-opacity-25 link-underline-opacity-50 link-underline-opacity-75 link-underline-opacity-100 link-underline-hover link-underline-hover-opacity-0 link-underline-hover-opacity-25 link-underline-hover-opacity-50 link-underline-hover-opacity-75 link-underline-hover-opacity-100 link-underline-hover-opacity-75-hover link-underline-hover-opacity-50-hover link-underline-hover-opacity-25-hover link-underline-hover-opacity-0-hover link-underline-opacity-0-hover link-underline-opacity-25-hover link-underline-opacity-50-hover link-underline-opacity-75-hover link-underline-opacity-100-hover link-underline-opacity-75 link-underline-opacity-50 link-underline-opacity-25 link-underline-opacity-0 link-underline link-underline-hover link-underline-hover-opacity-0 link-underline-hover-opacity-25 link-underline-hover-opacity-50 link-underline-hover-opacity-75 link-underline-hover-opacity-100 link-underline-hover-opacity-75-hover link-underline-hover-opacity-50-hover link-underline-hover-opacity-25-hover link-underline-hover-opacity-0-hover link-underline-opacity-0-hover link-underline-opacity-25-hover link-underline-opacity-50-hover link-underline-opacity-75-hover link-underline-opacity-100-hover link-underline-opacity-75 link-underline-opacity-50 link-underline-opacity-25 link-underline-opacity-0 link-underline link-underline-hover link-underline-hover-opacity-0 link-underline-hover-opacity-25 link-underline-hover-opacity-50 link-underline-hover-opacity-75 link-underline-hover-opacity-100 link-underline-hover-opacity-75-hover link-underline-hover-opacity-50-hover link-underline-hover-opacity-25-hover link-underline-hover-opacity-0-hover link-underline-opacity-0-hover link-underline-opacity-25-hover link-underline-opacity-50-hover link-underline-opacity-75-hover link-underline-opacity-100-hover link-underline-opacity-75 link-underline-opacity-50 link-underline-opacity-25 link-underline-opacity-0 link-underline link-underline-hover link-underline-hover-opacity-0 link-underline-hover-opacity-25 link-underline-hover-opacity-50 link-underline-hover-opacity-75 link-underline-hover-opacity-100 link-underline-hover-opacity-75-hover link-
        
        if let color = color {
            // set the style colour using the onmouseover event
            
        }
        
        if let background = background {
            // set the style background using the onmouseover event
            
        }
        
        if let bold = bold {
            // set the style font weight using the onmouseover event
            executingWebThread?.builderScript("\(builderId).classList.add('link-bold-hover');")
        }
        
        if let underline = underline, underline {
            executingWebThread?.builderScript("\(builderId).classList.add('link-underline');")
            executingWebThread?.builderScript("\(builderId).classList.add('link-underline-opacity-0');")
            executingWebThread?.builderScript("\(builderId).classList.add('link-underline-hover');")
            executingWebThread?.builderScript("\(builderId).classList.add('link-underline-opacity-100-hover');")
        }
        
        return self
    }
}
