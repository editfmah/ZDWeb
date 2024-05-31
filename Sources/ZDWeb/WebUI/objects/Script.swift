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
        executionPipeline()?.context?.script(url: url)
    }
    public init(_ script: String) {
        super.init()
        executionPipeline()?.context?.builderScript(script)
    }
}
