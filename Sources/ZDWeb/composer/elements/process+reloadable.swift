//
//  reloadable.swift
//  
//
//  Created by Adrian Herridge on 13/12/2022.
//

import Foundation

public extension WebRequestContext {
    func reloadable(id: String, url: String, timer: Int? = nil, block: String? = nil,_ closure: WebComposerClosure? = nil) {
        self.block(block ?? "div") {
            self.id(id)
            self.script("$('#\(id)').load('\(url)');")
            self.script("$('#\(id)').first.reload = function() { $('#\(id)').load('\(url)'); }")
            if let timer = timer {
                self.script("const interval\(id) = setInterval($('#\(id)').first.reload, \(timer * 1000));")
                self.script("function stop\(id)(){ clearInterval(interval\(id)) };")
            }
            if let closure = closure {
                closure()
            }
        }
    }
}
