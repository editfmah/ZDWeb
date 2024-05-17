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
