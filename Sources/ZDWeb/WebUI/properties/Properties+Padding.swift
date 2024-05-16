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
        executingWebThread?.builderScript("\(builderId).style.padding = '\(padding)px';")
        return self
    }
    @discardableResult
    func padding(_ position: WebAreaPosition, _ padding: Int) -> Self {
        switch position {
        case .leading:
            executingWebThread?.builderScript("\(builderId).style.paddingLeft = '\(padding)px';")
        case .trailing:
            executingWebThread?.builderScript("\(builderId).style.paddingRight = '\(padding)px';")
        case .top:
            executingWebThread?.builderScript("\(builderId).style.paddingTop = '\(padding)px';")
        case .bottom:
            executingWebThread?.builderScript("\(builderId).style.paddingBottom = '\(padding)px';")
        case .all:
            executingWebThread?.builderScript("\(builderId).style.padding = '\(padding)px';")
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
