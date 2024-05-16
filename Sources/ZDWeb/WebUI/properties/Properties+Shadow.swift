//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation
extension GenericProperties {
    @discardableResult
    func shadow(_ shadow: Int) -> Self {
        executingWebThread?.builderScript("\(builderId).style.boxShadow = '0px 0px \(shadow)px 0px rgba(0,0,0,0.75)';")
        return self
    }
}
