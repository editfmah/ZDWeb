//
//  File.swift
//  
//
//  Created by Adrian Herridge on 16/01/2023.
//

import Foundation

public class DropdownBuilder {
    
    private var c: WebRequestContext
    private var name: String?
    
    public init(c: WebRequestContext, name: String? = nil) {
        self.c = c
        self.name = name
    }
    
    public func option(value: String, body: WebComposerClosure) {
        c.block("li") {
            let id = value.md5
            c.script("""
function func\(id)() {
    $('#\(name ?? "")').val('\(value)');
    $('#dropdown-selected-content-\(name ?? "unnamed")').html($('#dropdown-option-\(id)').html());
}
""")
            c.row {
                c.id("dropdown-option-\(id)")
                c.property(property: "onClick", value: "func\(id)();")
                c.class("dropdown-item")
                body()
            }
        }
    }
    
}

public extension WebRequestContext {
    
    func dropdown(style: Style? = nil, title: String? = nil, name: String? = nil, value: String? = nil, content: (_ dropdown: DropdownBuilder) -> Void) {
        self.row {
            self.column(.none) {
                div("dropdown") {
                    if let name = name {
                        self.hidden(name: name, value: value ?? "")
                    }
                    button(type: "button", class: "btn btn-\(style?.rawValue ?? "primary") dropdown-toggle") {
                        property(property: "data-bs-toggle", value: "dropdown")
                        if let title = title {
                            self.text(title)
                        }
                        self.div {
                            self.id("dropdown-selected-content-\(name ?? "unnamed")")
                        }
                    }
                    // now we iterate the potential values
                    ul {
                        self.class("dropdown-menu dropdown-menu-end")
                        content(DropdownBuilder(c: self, name: name))
                    }
                    if let value = value {
                        self.script("func\(value.md5)();")
                    }
                }
            }
        }
    }
    
}
