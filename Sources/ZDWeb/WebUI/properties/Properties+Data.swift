//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation
public extension GenericProperties {
    @discardableResult
    func name(_ name: String) -> Self {
        executingWebThread?.builderScript("\(builderId).name = '\(name)';")
        return self
    }
    @discardableResult
    func value(_ value: String) -> Self {
        executingWebThread?.builderScript("\(builderId).value = '\(value)';")
        return self
    }
    @discardableResult
    func id(_ id: String) -> Self {
        executingWebThread?.builderScript("\(builderId).id = '\(id)';")
        return self
    }
}
