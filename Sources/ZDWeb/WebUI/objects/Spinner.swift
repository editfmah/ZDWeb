//
//  File.swift
//  
//
//  Created by Adrian Herridge on 27/07/2024.
//

import Foundation

public protocol WebSpinnerProperties: GenericProperties {
    @discardableResult
    func size(_ size: SpinnerSize) -> Self
    
    @discardableResult
    func color(_ color: WebColor) -> Self
    
    @discardableResult
    func type(_ type: SpinnerType) -> Self
    
    @discardableResult
    func label(_ text: String?) -> Self
}

public enum SpinnerSize: String {
    case small = "spinner-border-sm"
    case medium = ""
    case large = "spinner-border-lg"
}

public enum SpinnerType: String {
    case border = "spinner-border"
    case grow = "spinner-grow"
}

public extension WebSpinnerProperties {
    @discardableResult
    func size(_ size: SpinnerSize) -> Self {
        script("""
        if (\(builderId)) {
            \(builderId).classList.remove('spinner-border-sm', 'spinner-border-lg', 'spinner-grow-sm', 'spinner-grow-lg');
            if ('\(size.rawValue)' !== '') {
                \(builderId).classList.add('\(size.rawValue)');
            }
        }
        """)
        return self
    }

    @discardableResult
    func color(_ color: WebColor) -> Self {
        script("""
        if (\(builderId)) {
            \(builderId).style.color = '\(color.rgba)';
        }
        """)
        return self
    }

    @discardableResult
    func type(_ type: SpinnerType) -> Self {
        script("""
        if (\(builderId)) {
            \(builderId).classList.remove('spinner-border', 'spinner-grow');
            \(builderId).classList.add('\(type.rawValue)');
        }
        """)
        return self
    }

    @discardableResult
    func label(_ text: String?) -> Self {
        script("""
        if (\(builderId)) {
            var label = \(builderId).querySelector('.sr-only');
            if (label) {
                label.textContent = '\(text ?? "")';
            }
        }
        """)
        return self
    }
}

public class Spinner: WebElement, WebSpinnerProperties {
    @discardableResult
    public init(type: SpinnerType = .border, size: SpinnerSize = .medium, color: WebColor = .blue, label: String? = "Loading...") {
        super.init()
        
        declare("div", classList: "\(type.rawValue) " + builderId, attributes: ["role": "status"]) {
            declare("span", classList: "sr-only") {
                context.text(label ?? "")
            }
        }
        
        // create the object links
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        self.type(type)
        self.size(size)
        self.color(color)
        self.label(label)
    }
}

