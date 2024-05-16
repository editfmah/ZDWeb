//
//  process+table.swift
//  
//
//  Created by Adrian Herridge on 07/10/2021.
//

import Foundation

public enum TableClassProperties : String {
    case borderless = "table-borderless"
}

public class TableHeaderBuilder {
    
    private var c: WebRequestContext
    
    public init(c: WebRequestContext) {
        self.c = c
    }
    
    public func style(style: Style) {
        c.class("table-\(style.rawValue)")
    }
    
    public func cell(style: Style? = nil, label: String? = nil, _ content: WebComposerClosure? = nil) {
        c.block("th") {
            if let style = style {
                c.class("table-\(style.rawValue)")
            }
            c.property(property: "scope", value: "col")
            if let label = label {
                c.text(label)
            }
            if let content = content {
                content()
            }
        }
    }
    
}

public class TableContentBuilder {
    
    private var c: WebRequestContext
    
    public init(c: WebRequestContext) {
        self.c = c
    }
    
    public func row(style: Style? = nil, classes: String? = nil, link: WebNavigationPosition? = nil, _ rowComposer: (_ row: RowContentBuilder) -> Void) {
        c.block("tr") {
            if let style = style {
                c.class("table-\(style.rawValue)" + (classes != nil ? (" " + classes!) : ""))
            }
            rowComposer(RowContentBuilder(c: c, link: link))
        }
    }
    
}

public class RowContentBuilder {
    
    private var c: WebRequestContext
    private var l: WebNavigationPosition?
    
    public init(c: WebRequestContext, link: WebNavigationPosition?) {
        self.c = c
        self.l = link
    }
    
    public func cell(style: Style? = nil, label: String? = nil, span: Int? = nil, doNotLink: Bool, _ content: WebComposerClosure? = nil) {
        c.block("td") {
            if let style = style {
                c.class("table-\(style.rawValue)")
            }
            if let span = span {
                c.property(property: "colspan", value: "\(span)")
            }
            if let label = label {
                if let l = l, doNotLink == false {
                    c.link(url: l.url) {
                        c.text(label)
                    }
                } else {
                    c.text(label)
                }
            }
            if let content = content {
                if let l = l, doNotLink == false {
                    c.link(url: l.url) {
                        content()
                    }
                } else {
                    content()
                }
                
            }
        }
    }
    
    public func cell(style: Style? = nil, label: String? = nil, span: Int? = nil, _ content: WebComposerClosure? = nil) {
        c.block("td") {
            if let style = style {
                c.class("table-\(style.rawValue)")
            }
            if let span = span {
                c.property(property: "colspan", value: "\(span)")
            }
            if let label = label {
                if let l = l {
                    c.link(url: l.url) {
                        c.text(label)
                    }
                } else {
                    c.text(label)
                }
            }
            if let content = content {
                if let l = l {
                    c.link(url: l.url) {
                        content()
                    }
                } else {
                    content()
                }
                
            }
        }
    }
    
}

public extension WebRequestContext {
    
    func table(properties: [TableClassProperties]? = nil, headerBuilder: (_ header: TableHeaderBuilder) -> Void, contentBuilder: (_ content: TableContentBuilder) -> Void) {
        block("table") {
            if let properties {
                self.class("table " + properties.map({ $0.rawValue }).joined(separator: " "))
            } else {
                self.class("table")
            }
            
            self.block("thead") {
                self.block("tr") {
                    headerBuilder(TableHeaderBuilder(c: self))
                }
            }
            self.block("tbody") {
                contentBuilder(TableContentBuilder(c: self))
            }
        }
    }
    
    func table(_ closure: WebComposerClosure) {
        block("table") {
            closure()
        }
    }
    
    func tableheader(_ closure: WebComposerClosure) {
        block("thead") {
            closure()
        }
    }
    
    func tablebody(_ closure: WebComposerClosure) {
        block("tbody") {
            closure()
        }
    }
    
    func tablerow(_ closure: WebComposerClosure) {
        block("tr") {
            closure()
        }
    }
    
    func tablecell(_ closure: WebComposerClosure) {
        block("td") {
            closure()
        }
    }
    
    func tableheadercell(_ closure: WebComposerClosure) {
        block("th") {
            closure()
        }
    }
    
}
