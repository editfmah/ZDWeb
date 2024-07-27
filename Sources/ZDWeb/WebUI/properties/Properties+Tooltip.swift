//
//  Properties + Tooltip.swift
//
//
//  Created by Adrian Herridge on 25/07/2024.
//

import Foundation

public extension GenericProperties {
    
    // bootstrap 5 tooltip
    @discardableResult
    func tooltip(_ text: String) -> Self {
        script("var tooltip = new bootstrap.Tooltip(\(builderId), { title: '\(text)' });")
        return self
    }
    
}
