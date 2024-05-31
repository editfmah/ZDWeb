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
        executionPipeline()?.context?.builderScript("\(builderId).name = '\(name)';")
        return self
    }
    @discardableResult
    func value(_ value: String) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).value = '\(value)';")
        return self
    }
    @discardableResult
    func ref(_ id: String) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).id = '\(id)';")
        // now we also have to create a link to the object type
        if let type = executionPipeline()?.types[self.builderId] {
            executionPipeline()?.types[id] = type
        }
        return self
    }
}
