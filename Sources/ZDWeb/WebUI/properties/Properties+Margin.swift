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
        executingWebThread?.builderScript("\(builderId).style.margin = '\(margin)px';")
        return self
    }
    @discardableResult
    func margin(_ position: WebAreaPosition, _ margin: Int) -> Self {
        switch position {
        case .leading:
            executingWebThread?.builderScript("\(builderId).style.marginLeft = '\(margin)px';")
        case .trailing:
            executingWebThread?.builderScript("\(builderId).style.marginRight = '\(margin)px';")
        case .top:
            executingWebThread?.builderScript("\(builderId).style.marginTop = '\(margin)px';")
        case .bottom:
            executingWebThread?.builderScript("\(builderId).style.marginBottom = '\(margin)px';")
        case .all:
            executingWebThread?.builderScript("\(builderId).style.margin = '\(margin)px';")
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
}
