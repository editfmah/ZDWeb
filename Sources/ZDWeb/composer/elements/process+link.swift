//
//  process+link.swift
//  process+link
//
//  Created by Adrian Herridge on 09/09/2021.
//

import Foundation

public extension WebRequestContext {
    func link(title: String, destination: WebNavigationPosition, _ closure: WebComposerClosure? = nil) {
        if let closure = closure {
            self.block("a") {
                self.property(property: "href", value: destination.url)
                closure()
                self.text(title)
            }
        } else {
            self.output("<a href=\"\(destination.url)\">\(title)</a>")
        }
    }
    func link(title: String, url: String, _ closure: WebComposerClosure? = nil) {
        if let closure = closure {
            self.block("a") {
                self.property(property: "href", value: url)
                closure()
                self.text(title)
            }
        } else {
            self.output("<a href=\"\(url)\">\(title)</a>")
        }
    }
    func link(url: String, _ content: WebComposerClosure) {
        self.block("a") {
            self.property(property: "href", value: url)
            content()
        }
    }
    func mailto(user: String, domain: String) {
        self.output("<template obscure data-p1=\"\(user)\" data-p2=\"\(domain)\"><a href=\"mailto:%1@%2\">%1@%2</a></template>")
    }
    func telno(country: String, prefix: String, primary: String, secondary: String) {
        self.output("""
<template obscure data-p1="\(country)" id="test2" class="test1" data-p2="\(prefix)" data-p3="\(primary)" data-p4="\(secondary)"><a href=\"tel:%1%3%4\">%1 (%2) %3%4</a></template>
""")
    }
}

public extension WebRequestContext {
    
    func link(rel: String? = nil, ref: String? = nil, type: String? = nil) {
        var output = "<link"
        
        if let value = rel {
            output += " rel=\"\(value)\""
        }
        
        if let value = ref {
            output += " href=\"\(value)\""
        }
        
        if let value = type {
            output += " type=\"\(value)\""
        }
        
        output += ">"
        
        self.output(output)
        
    }
    
}
