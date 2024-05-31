//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation
public extension GenericProperties {
    @discardableResult
    func padding(_ padding: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.padding = '\(padding)px';")
        return self
    }
    @discardableResult
    func padding(_ position: WebAreaPosition, _ padding: Int) -> Self {
        switch position {
        case .leading:
            executionPipeline()?.context?.builderScript("\(builderId).style.paddingLeft = '\(padding)px';")
        case .trailing:
            executionPipeline()?.context?.builderScript("\(builderId).style.paddingRight = '\(padding)px';")
        case .top:
            executionPipeline()?.context?.builderScript("\(builderId).style.paddingTop = '\(padding)px';")
        case .bottom:
            executionPipeline()?.context?.builderScript("\(builderId).style.paddingBottom = '\(padding)px';")
        case .all:
            executionPipeline()?.context?.builderScript("\(builderId).style.padding = '\(padding)px';")
        }
        return self
    }
    @discardableResult
    func padding(_ positions: [WebAreaPosition], _ padding: Int) -> Self {
        for position in positions {
            let _ = self.padding(position, padding)
        }
        return self
    }
}
