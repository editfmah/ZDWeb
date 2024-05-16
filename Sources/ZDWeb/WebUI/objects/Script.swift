//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public class Script : WebImageElement {
    @discardableResult
    public init(url: String) {
        super.init()
        executingWebThread?.script(url: url)
    }
    public init(_ script: String) {
        super.init()
        executingWebThread?.builderScript(script)
    }
}
