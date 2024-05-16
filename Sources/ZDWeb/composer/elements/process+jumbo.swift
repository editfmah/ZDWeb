//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/01/2023.
//

import Foundation

public extension WebRequestContext {
    
//    <div class="mt-4 p-5 bg-primary text-white rounded">
//      <h1>Jumbotron Example</h1>
//      <p>Lorem ipsum...</p>
//    </div>
    
    func jumbo(style: Style? = nil, title: String? = nil,_ closure: WebComposerClosure) {
        let style = style ?? .Primary
        self.div("mt-4 p-5 bg-\(style.rawValue) text-white rounded", {
            if let title = title {
                self.h1(title)
            }
            closure()
        })
    }
}
