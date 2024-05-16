//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public extension GenericProperties {
    @discardableResult
    func background(_ color: WebColor) -> Self {
        executingWebThread?.builderScript("\(builderId).style.backgroundColor = '\(color.rgba)';")
        return self
    }
}
