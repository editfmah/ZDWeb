//
//  onClick.swift
//  
//
//  Created by Adrian Herridge on 16/03/2023.
//

import Foundation

public extension WebRequestContext {
    func onClick(_ script: String) {
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        self.property(property: "onclick", value: "func\(id)();")
        self.script("""
function func\(id)() {
    \(script)
}
""")
    }
}
