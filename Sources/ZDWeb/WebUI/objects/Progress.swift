//
//  File.swift
//  
//
//  Created by Adrian Herridge on 27/07/2024.
//

import Foundation

public protocol WebProgressProperties: GenericProperties {
    @discardableResult
    func striped(_ enable: Bool) -> Self
    
    @discardableResult
    func animated(_ enable: Bool) -> Self
    
    @discardableResult
    func label(_ show: Bool) -> Self
    
    @discardableResult
    func color(_ color: WebColor) -> Self
    
    @discardableResult
    func max(_ value: Int) -> Self
}

public extension WebProgressProperties {
    @discardableResult
    func striped(_ enable: Bool) -> Self {
        script("""
        if (\(builderId)) {
            if (\(enable)) {
                \(builderId).classList.add('progress-bar-striped');
            } else {
                \(builderId).classList.remove('progress-bar-striped');
            }
        }
        """)
        return self
    }

    @discardableResult
    func animated(_ enable: Bool) -> Self {
        script("""
        if (\(builderId)) {
            if (\(enable)) {
                \(builderId).classList.add('progress-bar-animated');
            } else {
                \(builderId).classList.remove('progress-bar-animated');
            }
        }
        """)
        return self
    }

    @discardableResult
    func label(_ show: Bool) -> Self {
        script("""
        if (\(builderId)) {
            var label = \(builderId).querySelector('.progress-label');
            if (label) {
                label.style.display = \(show ? "block" : "none");
            }
        }
        """)
        return self
    }

    @discardableResult
    func color(_ color: WebColor) -> Self {
        script("""
        if (\(builderId)) {
            \(builderId).style.backgroundColor = '\(color.rgba)';
        }
        """)
        return self
    }

    @discardableResult
    func max(_ value: Int) -> Self {
        script("""
        if (\(builderId)) {
            \(builderId).setAttribute('aria-valuemax', '\(value)');
        }
        """)
        return self
    }
}

import Foundation

public class Progress: WebElement, WebProgressProperties {
    @discardableResult
    public init(bindTo value: WInt, maxValue: Int = 100, showLabel: Bool = true) {
        super.init()
        
        declare("div", classList: "progress " + builderId) {
            declare("div", classList: "progress-bar", attributes: ["role": "progressbar", "aria-valuenow": "\(value.builderId)", "aria-valuemin": "0", "aria-valuemax": "\(maxValue)", "style": "width: \(value.builderId)%;"]) {
                if showLabel {
                    declare("span", classList: "progress-label") {
                        context.text("\(value.builderId)%")
                    }
                }
            }
        }
        
        // create the object links
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        script("""
        var progressValue = document.getElementById('\(value.builderId)');
        if (progressValue) {
            progressValue.addEventListener('change', function() {
                var progressBar = document.querySelector('.progress-bar');
                if (progressBar) {
                    progressBar.setAttribute('aria-valuenow', progressValue.value);
                    progressBar.style.width = progressValue.value + '%';
                    var label = progressBar.querySelector('.progress-label');
                    if (label) {
                        label.textContent = progressValue.value + '%';
                    }
                }
            });
        }
        """)
    }
}
