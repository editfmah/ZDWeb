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
        context.script(url: url)
    }
    public init(_ scripts: String) {
        super.init()
        script(scripts)
    }
}
