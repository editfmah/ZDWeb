//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

class Script : WebImageElement {
    @discardableResult
    init(url: String) {
        super.init()
        executingWebThread?.script(url: url)
    }
    init(_ script: String) {
        super.init()
        executingWebThread?.builderScript(script)
    }
}
