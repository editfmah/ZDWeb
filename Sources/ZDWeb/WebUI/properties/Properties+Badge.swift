//
//  File.swift
//  
//
//  Created by Adrian Herridge on 27/07/2024.
//

import Foundation

// Extension for generic properties
public extension GenericProperties {

    @discardableResult
    func badge(style: BadgeStyle, text: String) -> Self {
        let badgeId = "\(builderId)-badge"
        script("""
            var parentElement = \(builderId);
            if (parentElement) {
                var badgeElement = document.createElement('span');
                badgeElement.id = '\(badgeId)';
                badgeElement.className = 'position-absolute top-0 start-100 translate-middle badge rounded-pill \(style.rawValue)';
                badgeElement.innerText = '\(text)';
                var visuallyHiddenElement = document.createElement('span');
                visuallyHiddenElement.className = 'visually-hidden';
                visuallyHiddenElement.innerText = 'unread messages';
                badgeElement.appendChild(visuallyHiddenElement);
                parentElement.appendChild(badgeElement);
                parentElement.classList.add('position-relative');
            }
        """)
        return self
    }
}
