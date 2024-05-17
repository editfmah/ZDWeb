//
//  Properties+Hover.swift
//
//
//  Created by Adrian Herridge on 16/05/2024.
//

import Foundation

public extension GenericProperties {
    @discardableResult
    func hover(_ color: WebColor? = nil, underline: Bool? = nil, underlineColor: WebColor? = nil, opacity: WebOpacity? = nil) -> Self {
        
        var mouseover = ""
        var mouseout = ""
     
        if let color = color {
            mouseover += "\(builderId)_pre_color = \(builderId).style.color;\n"
            mouseover += "\(builderId).style.color = '\(color.rgba)';\n"
            mouseout += "\(builderId).style.color =  \(builderId)_pre_color;\n"
        }
        
        if let underlineColor = underlineColor {
            mouseover += "\(builderId)_pre_underline_color = \(builderId).style.textDecorationColor;\n"
            mouseover += "\(builderId).style.textDecorationColor = '\(underlineColor.rgba)';\n"
            mouseout += "\(builderId).style.textDecorationColor =  \(builderId)_pre_underline_color;\n"
        }
        
        if let underline = underline, underline {
            mouseover += "\(builderId)_pre_underline = \(builderId).style.textDecoration;\n"
            mouseover += "\(builderId).style.textDecoration = 'underline';\n"
            mouseout += "\(builderId).style.textDecoration =  \(builderId)_pre_underline;\n"
        }
        
        if let opacity = opacity {
            mouseover += "\(builderId)_pre_opacity = \(builderId).style.opacity;\n"
            mouseover += "\(builderId).style.opacity = \(opacity.cssValue);\n"
            mouseout += "\(builderId).style.opacity =  \(builderId)_pre_opacity;\n"
        }
        
        // record the existing values for colour, underline, bold, underline color, opacity and restore them on mouse off
        executingWebThread?.builderScript("""

\(builderId).addEventListener('mouseover', function() {
\(mouseover)
});

\(builderId).addEventListener('mouseout', function() {
\(mouseout)
});

""")
        
        if let color = color {
            // set the style colour using the onmouseover event
            if let type = executingElementType {
                switch type {
                case .text:
                    break;
                case .button:
                    break;
                case .link:
                    executingWebThread?.builderScript("\(builderId).classList.add('link-\(color.bsColor)-hover');")
                case .image:
                    break;
                }
            }
        }
        
        if let underlineColor = underlineColor {
            if let type = executingElementType {
                switch type {
                case .text:
                    break;
                case .button:
                    break;
                case .link:
                    executingWebThread?.builderScript("\(builderId).classList.add('link-underline-\(underlineColor.bsColor)-hover');")
                case .image:
                    break;
                }
            }
        }
        
        if let opacity = opacity {
            if let type = executingElementType {
                switch type {
                case .text:
                    break;
                case .button:
                    break;
                case .link:
                    executingWebThread?.builderScript("\(builderId).classList.add('link-opacity-\(opacity.bsValue)-hover');")
                case .image:
                    break;
                }
            }
        }
        
        if let underline = underline, underline {
            if let type = executingElementType {
                switch type {
                case .text:
                    break;
                case .button:
                    break;
                case .link:
                    executingWebThread?.builderScript("\(builderId).classList.add('link-underline');")
                    executingWebThread?.builderScript("\(builderId).classList.add('link-underline-opacity-0');")
                    executingWebThread?.builderScript("\(builderId).classList.add('link-underline-hover');")
                    executingWebThread?.builderScript("\(builderId).classList.add('link-underline-opacity-100-hover');")
                case .image:
                    break;
                }
            }
        }
        
        return self
    }
}
