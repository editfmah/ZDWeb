//
//  process+select.swift
//  WebServer
//
//  Created by Adrian Herridge on 29/09/2021.
//

import Foundation

public extension WebRequestContext {
    func select(name: String, values:[String], selected: String? = nil) {
        self.block("select") {
            self.id(name)
            self.name(name)
            for v in values {
                self.block("option") {
                    if v == selected {
                        self.tag(property: "selected")
                    }
                    self.text(v)
                }
            }
        }
    }
    func actionselect(name: String, values:[(title: String, value: String, selected: Bool)], onChange: String?) {
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        self.block("select") {
            self.id(id)
            self.name(id)
            for v in values {
                self.block("option") {
                    if v.selected {
                        self.tag(property: "selected")
                    }
                    self.text(v.title)
                    self.value(v.value)
                }
            }
        }
        self.script("""
    $( "#\(id)" ).selectmenu({
        width : 'auto',
        change: function( event, data ) {
            var value = data.item.value;
            \(onChange ?? "")
        }
     });
""")
    }
}
