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
        
        if let color = color {
            // set the style colour using the onmouseover event
            executingWebThread?.builderScript("\(builderId).onmouseover = function() { \(builderId).style.color = '\(color.rgba)'; };")
        }
        
        if let background = background {
            // set the style background using the onmouseover event
            executingWebThread?.builderScript("\(builderId).onmouseover = function() { \(builderId).style.backgroundColor = '\(background.rgba)'; };")
        }
        
        if let bold = bold {
            // set the style font weight using the onmouseover event
            executingWebThread?.builderScript("\(builderId).onmouseover = function() { \(builderId).style.fontWeight = '\(bold ? "bold" : "normal")'; };")
        }
        
        if let underline = underline {
            // set the style text decoration using the onmouseover event
            executingWebThread?.builderScript("\(builderId).onmouseover = function() { \(builderId).style.textDecoration = '\(underline ? "underline" : "none")'; };")
        }
        
        return self
    }
}
