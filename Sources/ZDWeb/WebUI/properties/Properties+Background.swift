//
//  Properties+Background.swift
//
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public extension GenericProperties {
    @discardableResult
    func background(_ color: WebColor) -> Self {
        script("\(builderId).style.backgroundColor = '\(color.rgba)';")
        return self
    }
    @discardableResult
    func background(_ direction: WebGradientDirection, _ colors: [WebColor]) -> Self {
        script("\(builderId).style.backgroundImage = 'linear-gradient(\(direction.rawValue), \(colors.map({ $0.rgba }).joined(separator: ", ")))';")
        return self
    }
}
