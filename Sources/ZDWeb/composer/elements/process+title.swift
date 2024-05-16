//
//  process+title.swift
//  process+title
//
//  Created by Adrian Herridge on 08/09/2021.
//

import Foundation

public extension WebRequestContext {
    func title(_ value: String) {
        self.block("title") {
            self.text(value)
        }
    }
}
