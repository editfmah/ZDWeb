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
        declare("th", identifier: self.builderId, {
            context.text(text)
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
    @discardableResult
    public init(_ text: WString) {
        super.init()
        declare("th", identifier: self.builderId, {
            context.text(text.internalValue)
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}

public class Cell : WebElement {
    @discardableResult
    public init(_ text: String) {
        super.init()
        declare("td", identifier: self.builderId, {
            context.text(text)
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
    @discardableResult
    public init(_ text: WString) {
        super.init()
        declare("td", identifier: self.builderId, {
            context.text(text.internalValue)
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}

public class TableHeader : WebElement {
        
        @discardableResult
        public init(_ closure: WebComposerClosure) {
            super.init()
            declare("thead", identifier: self.builderId, {
                closure()
            })
            script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        }
        
    }

public class TableRow : WebElement {
        
        @discardableResult
        public init(_ closure: WebComposerClosure) {
            super.init()
            declare("tr", identifier: self.builderId, {
                closure()
            })
        }
    }

public class TableBody : WebElement {
        
        @discardableResult
        public init(_ closure: WebComposerClosure) {
            super.init()
            declare("tbody", identifier: self.builderId, {
                closure()
            })
        }
        
    }


public class Table : WebTableElement {
    @discardableResult
    public init(_ body: WebComposerClosure) {
        super.init()
        declare("table", identifier: self.builderId, {
            body()
        })
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("table")
    }
}
