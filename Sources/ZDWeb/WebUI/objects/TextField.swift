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
    var isUserInput\(builderId) = false;
    var debounceTimer\(builderId);
    \(builderId).addEventListener('input', function() {
        isUserInput\(builderId) = true;
        clearTimeout(debounceTimer\(builderId));
        debounceTimer\(builderId) = setTimeout(function() {
            \(binding.builderId) = \(builderId).value.split(/[,;|]/).map(function(item) {
                return item.trim();
            }).filter(function(item) {
                return item.length > 0;
            });
            isUserInput\(builderId) = false;
        }, 300);
    });

    function updateTextField\(builderId)() {
        var value = \(binding.builderId).join(', ');
        if (!isUserInput\(builderId) && \(builderId).value !== value) {
            \(builderId).value = value;
        }
        setTimeout(updateTextField\(builderId), 500);
    }
    updateTextField\(builderId)();
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
    function updateTextField\(builderId)() {
        if (\(builderId).value !== \(binding.builderId)) {
            \(builderId).value = \(binding.builderId);
        }
        setTimeout(updateTextField\(builderId), 500);
    }
    updateTextField\(builderId)();
    """)
        }
    }
}
