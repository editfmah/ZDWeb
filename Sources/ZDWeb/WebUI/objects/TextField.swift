//
//  File.swift
//
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class TextField: WebElement {
    @discardableResult
    public init(_ placeholder: String, name: String? = nil, binding: WArray? = nil) {
        super.init()
        declare("input", classList: self.builderId , {
            
        })
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        script("\(builderId).placeholder = '\(placeholder)';")
        addClass("form-control")

        if let binding = binding {
            script("""
    var isUserInput = false;
    var debounceTimer;
    \(builderId).addEventListener('input', function() {
        isUserInput = true;
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(function() {
            \(binding.builderId) = \(builderId).value.split(/[,;|]/).map(function(item) {
                return item.trim();
            }).filter(function(item) {
                return item.length > 0;
            });
            isUserInput = false;
        }, 300);
    });

    function updateTextField() {
        var value = \(binding.builderId).join(', ');
        if (!isUserInput && \(builderId).value !== value) {
            \(builderId).value = value;
        }
        setTimeout(updateTextField, 500);
    }
    updateTextField();
    """)
        }
    }

    @discardableResult
    public init(_ placeholder: String, name: String? = nil, binding: WString? = nil) {
        super.init()
        declare("input", classList: self.builderId , {
            
        })
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        script("\(builderId).placeholder = '\(placeholder)';")
        addClass("form-control")
        
        if let binding = binding {
            script("""
    \(builderId).addEventListener('input', function() {
        \(binding.builderId) = \(builderId).value;
    });
    \(builderId).value = \(binding.builderId);
    function updateTextField() {
        if (\(builderId).value !== \(binding.builderId)) {
            \(builderId).value = \(binding.builderId);
        }
        setTimeout(updateTextField, 500);
    }
    updateTextField();
    """)
        }
    }
}
