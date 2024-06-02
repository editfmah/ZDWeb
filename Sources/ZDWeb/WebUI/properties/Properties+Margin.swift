//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation
public extension GenericProperties {
    @discardableResult
    func margin(_ margin: Int) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).style.margin = '\(margin)px';")
        return self
    }
    @discardableResult
    func margin(_ position: WebAreaPosition, _ margin: Int) -> Self {
        switch position {
        case .leading:
            executionPipeline()?.context?.builderScript("\(builderId).style.marginLeft = '\(margin)px';")
        case .trailing:
            executionPipeline()?.context?.builderScript("\(builderId).style.marginRight = '\(margin)px';")
        case .top:
            executionPipeline()?.context?.builderScript("\(builderId).style.marginTop = '\(margin)px';")
        case .bottom:
            executionPipeline()?.context?.builderScript("\(builderId).style.marginBottom = '\(margin)px';")
        case .all:
            executionPipeline()?.context?.builderScript("\(builderId).style.margin = '\(margin)px';")
        }
        return self
    }
    @discardableResult
    func margin(_ positions: [WebAreaPosition], _ margin: Int) -> Self {
        for position in positions {
            let _ = self.margin(position, margin)
        }
        return self
    }
    @discardableResult
    func margin(_ type: WebMarginType) -> Self {
        switch type {
        case .auto:
            executionPipeline()?.context?.builderScript("\(builderId).style.margin = 'auto';")
        case .none:
            executionPipeline()?.context?.builderScript("\(builderId).style.margin = 'unset';")
        }
        return self
    }
}
