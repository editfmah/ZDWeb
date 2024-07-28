//
//  File.swift
//  
//
//  Created by Adrian Herridge on 28/07/2024.
//

import Foundation

public extension GenericProperties {

    @discardableResult
    func backgroundImage(_ url: String) -> Self {
        script("\(builderId).style.backgroundImage = 'url(\(url))';")
        return self
    }

    @discardableResult
    func backgroundSize(_ size: WebBackgroundSize) -> Self {
        script("\(builderId).style.backgroundSize = '\(size.rawValue)';")
        return self
    }

    @discardableResult
    func backgroundRepeat(_ `repeat`: WebBackgroundRepeat) -> Self {
        script("\(builderId).style.backgroundRepeat = '\(`repeat`.rawValue)';")
        return self
    }

    @discardableResult
    func backgroundPosition(_ position: WebBackgroundPosition) -> Self {
        script("\(builderId).style.backgroundPosition = '\(position.rawValue)';")
        return self
    }

    @discardableResult
    func backgroundAttachment(_ attachment: String) -> Self {
        script("\(builderId).style.backgroundAttachment = '\(attachment)';")
        return self
    }
    
}
