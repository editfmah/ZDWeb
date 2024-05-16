//
//  File.swift
//  
//
//  Created by Adrian Herridge on 22/04/2022.
//

import Foundation

public extension WebRequestContext {
    
    func meta(charset: String? = nil, property: String? = nil, name: String? = nil, content: String? = nil) {
        var output = "<meta"
        
        if let cs = charset {
            output += " charset=\"\(cs)\""
        }
        
        if let value = property {
            output += " property=\"\(value)\""
        }
        
        if let value = name {
            output += " name=\"\(value)\""
        }
        
        if let value = content {
            output += " content=\"\(value)\""
        }
        output += ">"
        
        self.output(output)
        
    }
    
}
