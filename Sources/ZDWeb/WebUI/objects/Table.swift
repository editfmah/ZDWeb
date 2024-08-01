//
//  Table.swift
//
//
//  Created by Adrian Herridge on 20/07/2024.
//

import Foundation

public class HeaderCell : WebElement {
    @discardableResult
    public init(_ text: String) {
        super.init()
        declare("th", classList: self.builderId, {
            context.text(text)
        })
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
    @discardableResult
    public init(_ text: WString) {
        super.init()
        declare("th", classList: self.builderId, {
            context.text(text.internalValue)
        })
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}

public class Cell : WebElement {
    @discardableResult
    public init(_ text: String) {
        super.init()
        declare("td", classList: self.builderId, {
            context.text(text)
        })
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
    @discardableResult
    public init(_ text: WString) {
        super.init()
        declare("td", classList: self.builderId, {
            context.text(text.internalValue)
        })
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
    @discardableResult
    public init(_ body: WebComposerClosure) {
        super.init()
        declare("td", classList: self.builderId, {
            body()
        })
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}

public class TableHeader : WebElement {
        
        @discardableResult
        public init(_ closure: WebComposerClosure) {
            super.init()
            declare("thead", classList: self.builderId, {
                closure()
            })
            script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        }
        
    }

public class TableRow : WebElement {
        
        @discardableResult
        public init(_ closure: WebComposerClosure) {
            super.init()
            declare("tr", classList: self.builderId, {
                closure()
            })
        }
    }

public class TableBody : WebElement {
        
        @discardableResult
        public init(_ closure: WebComposerClosure) {
            super.init()
            declare("tbody", classList: self.builderId, {
                closure()
            })
        }
        
    }


public class Table : WebTableElement {
    @discardableResult
    public init(_ body: WebComposerClosure) {
        super.init()
        declare("table", classList: self.builderId, {
            body()
        })
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("table")
    }
}
