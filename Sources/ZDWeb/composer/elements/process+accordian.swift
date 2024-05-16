//
//  process+accordian.swift
//  WebServer
//
//  Created by Adrian Herridge on 28/09/2021.
//

import Foundation
public extension WebRequestContext {
    func accordion(_ closure: WebComposerClosure) {
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        self.block("div") {
            self.id(id)
            closure()
        }
        self.script("""
$( document ).ready(function() { $( function() { $( "#\(id)" ).accordion({
    heightStyle: "fill",
}); }); });
""")
    }
    func accordionSection(title: String, _ closure: WebComposerClosure) {
        self.h3(title)
        self.div {
            closure()
        }
    }
}
