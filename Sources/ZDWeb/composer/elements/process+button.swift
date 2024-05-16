//
//  process+button.swift
//  process+button
//
//  Created by Adrian Herridge on 13/09/2021.
//

import Foundation

//TODO: enum, type of button

public extension WebRequestContext {
    func button(style: Style? = .Primary, size: BootstrapSize? = .default, title: String, type: String, id: String? = nil) {
        let id = id ?? UUID().uuidString.lowercased()
        self.block("button") {
            self.id(id)
            self.class("btn btn-\(style?.rawValue ?? "primary") btn-\(size?.rawValue ?? "def")")
            self.type(type)
            self.output(title)
        }
    }
    func button(fontAwesome: String, style: Style, link: String? = nil, script: String? = nil) {
        let id = UUID().uuidString.lowercased()
        if let link = link {
            self.link(url: link) {
                self.id(id)
                self.role("button")
                self.class("btn btn-\(style.rawValue)")
                self.fontAwesome(fontAwesome, size: .Normal)
            }
        } else if let script = script {
            self.block("button") {
                self.id(id)
                self.class("btn btn-\(style.rawValue)")
                self.fontAwesome(fontAwesome, size: .Normal)
                self.onClick(script)
            }
        } else {
            self.block("button") {
                self.id(id)
                self.class("btn btn-\(style.rawValue)")
                self.fontAwesome(fontAwesome, size: .Normal)
            }
        }
        
        
    }
    func button(style: Style? = .Primary, size: BootstrapSize? = .default, title: String, link: String) {
        let id = UUID().uuidString.lowercased()
        self.link(url: link) {
            self.id(id)
            self.role("button")
            self.class("btn btn-\(style?.rawValue ?? "primary") btn-\(size?.rawValue ?? "def")")
            self.text(title)
        }
    }
    func button(style: Style? = .Primary, size: BootstrapSize? = .default, title: String, link: WebNavigationPosition? = nil, closure: WebComposerClosure? = nil) {
        let id = UUID().uuidString.lowercased()
        if let link = link {
            self.link(url: link.url) {
                self.id(id)
                self.role("button")
                self.class("btn btn-\(style?.rawValue ?? "primary") btn-\(size?.rawValue ?? "def")")
                self.text(title)
            }
        } else if let closure = closure {
            self.block("button") {
                self.id(id)
                self.class("btn btn-\(style?.rawValue ?? "primary") btn-\(size?.rawValue ?? "def")")
                self.type("button")
                closure()
                self.output(title)
            }
        }
    }
    func button(style: Style? = .Primary, size: BootstrapSize? = .default, title: String, script: String,_ closure: WebComposerClosure? = nil) {
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        self.block("button") {
            self.id(id)
            self.type("button")
            self.class("btn btn-\(style?.rawValue ?? "primary") btn-\(size?.rawValue ?? "def")")
            self.output(title)
            if let closure = closure {
                closure()
            }
            self.elementProperties[blocks.last!]!["onClick"] = "func\(id)()"
        }
        self.script("""
function func\(id)() {
    \(script)
}
""")
    }
    
    func button(type: String, `class`: String? = nil,_ closure: WebComposerClosure) {
        self.block("button") {
            self.type(type)
            if let `class` = `class` {
                self.class(`class`)
            }
            closure()
        }
    }
    
    func button(_ id: String, _ title: String, script: String) {
        self.block("button") {
            self.id(id)
            self.type("button")
            self.output(title)
            self.elementProperties[blocks.last!]!["onClick"] = "func\(id)()"
        }
        self.script("""
$( document ).ready(function() { $( function() { $( "#\(id)" ).button(); }); });
function func\(id)() {
    \(script)
}
""")
    }
    func button(imgUrl: String, size: Int, script: String) {
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        self.block("button") {
            self.id(id)
            self.type("button")
            self.elementProperties[blocks.last!]!["onClick"] = "func\(id)()"
        }
        self.script("""
$( document ).ready(function() { $( function() { $( "#\(id)" ).append(\"<img style='width: \(size)px; height=\(size)px; object-fit: cover; object-position: center;' src=\(imgUrl) />\").button(); }); });
function func\(id)() {
    \(script)
}
""")
    }
    func button(size: Int, script: String, _ builder: WebComposerClosure?) {
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        self.block("button") {
            self.id(id)
            self.type("button")
            self.elementProperties[blocks.last!]!["onClick"] = "func\(id)()"
            builder?()
        }
        self.script("""
$( document ).ready(function() { $( function() { $( "#\(id)" ).button(); }); });
function func\(id)() {
    \(script)
}
""")
    }
}
