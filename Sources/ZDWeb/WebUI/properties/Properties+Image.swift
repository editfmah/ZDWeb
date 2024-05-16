//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

extension ImageProperties {
    func src(_ src: String) -> Self {
        executingWebThread?.builderScript("\(builderId).src = '\(src)';")
        return self
    }
    func alt(_ alt: String) -> Self {
        executingWebThread?.builderScript("\(builderId).alt = '\(alt)';")
        return self
    }
    func scaleToFit() -> Self {
        executingWebThread?.builderScript("\(builderId).style.objectFit = 'contain';")
        return self
    }
    func scaleToFill() -> Self {
        executingWebThread?.builderScript("\(builderId).style.objectFit = 'cover';")
        return self
    }
}
