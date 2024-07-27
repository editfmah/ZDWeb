//
//  File.swift
//  
//
//  Created by Adrian Herridge on 25/07/2024.
//

import Foundation

public extension GenericProperties {
    @discardableResult
    func collapsible() -> Self {
        addClass("collapse")
        return self
    }
}
