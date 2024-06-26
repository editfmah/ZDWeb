//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public extension ImageProperties {
    @discardableResult
    func src(_ src: String) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).src = '\(src)';")
        return self
    }
    @discardableResult
    func alt(_ alt: String) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).alt = '\(alt)';")
        return self
    }
    @discardableResult
    func scaleToFit() -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.objectFit = 'contain';")
        return self
    }
    @discardableResult
    func scaleToFill() -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.objectFit = 'cover';")
        return self
    }
}
