//
//  File.swift
//  
//
//  Created by Adrian Herridge on 17/05/2022.
//

import Foundation

public enum ColumnSize {
    case XXSmall
    case XSmall
    case Small
    case Medium
    case Large
    case XLarge
    case Auto
    case none
}

public extension WebRequestContext {
    
    func row(cls: String? = nil, _ closure: WebComposerClosure) {
        if let cls = cls {
            self.div("row \(cls)") {
                closure()
            }
        } else {
            self.div("row") {
                closure()
            }
        }
    }
    
    func column(_ size: ColumnSize, classes: String? = nil, _ closure: WebComposerClosure) {
        
        switch size {
        case .XXSmall:
            self.div("col-sm-1 \(classes ?? "")") { closure() }
        case .XSmall:
            self.div("col-sm-2 \(classes ?? "")") { closure() }
        case .Small:
            self.div("col-sm-4 \(classes ?? "")") { closure() }
        case .Medium:
            self.div("col-sm-6 \(classes ?? "")") { closure() }
        case .Large:
            self.div("col-sm-8 \(classes ?? "")") { closure() }
        case .XLarge:
            self.div("col-sm-10 \(classes ?? "")") { closure() }
        case .Auto:
            self.div("col-md-auto \(classes ?? "")") { closure() }
        case .none:
            self.div("col \(classes ?? "")") { closure() }
        }
    
    }
    
    func card(title: String? = nil, id: String? = nil, style: Style, spacing: CardSpacing? = .Medium, body: WebComposerClosure, footer: WebComposerClosure) {
        
        var spacingStyle = ""
        switch spacing! {
        case .None:
            spacingStyle = "mx-0 my-0"
        case .Small:
            spacingStyle = "mx-auto my-1"
        case .Medium:
            spacingStyle = "mx-auto my-2"
        case .Large:
            spacingStyle = "mx-auto my-3"
        }
        
        div("card \(spacingStyle)") {
            if let id = id {
                self.id(id)
            }
            if let title = title {
                switch style {
                case .Primary:
                    div("card-header bg-primary text-white") {
                        strong(title)
                    }
                case .Secondary:
                    div("card-header bg-secondary text-white") {
                        strong(title)
                    }
                case .Info:
                    div("card-header bg-info text-white") {
                        strong(title)
                    }
                case .Error:
                    div("card-header bg-error text-white") {
                        strong(title)
                    }
                case .Dark:
                    div("card-header bg-dark text-white") {
                        strong(title)
                    }
                case .Light:
                    div("card-header bg-light") {
                        strong(title)
                    }
                case .Success:
                    div("card-header bg-success text-white") {
                        strong(title)
                    }
                case .Warning:
                    div("card-header bg-warning text-white") {
                        strong(title)
                    }
                case .Basic:
                    div("card-header") {
                        strong(title)
                    }
                }
            }
            div("card-body") {
                body()
            }
            div("card-footer") {
                footer()
            }
        }
        
    }
    
    func card(title: String? = nil, id: String? = nil, style: Style, spacing: CardSpacing? = .Medium, _ body: WebComposerClosure) {
        
        var spacingStyle = ""
        switch spacing! {
        case .None:
            spacingStyle = "mx-0 my-0"
        case .Small:
            spacingStyle = "mx-auto my-1"
        case .Medium:
            spacingStyle = "mx-auto my-2"
        case .Large:
            spacingStyle = "mx-auto my-3"
        }
        
        div("card \(spacingStyle)") {
            if let id = id {
                self.id(id)
            }
            if let title = title {
                switch style {
                case .Primary:
                    div("card-header bg-primary text-white") {
                        strong(title)
                    }
                case .Secondary:
                    div("card-header bg-secondary text-white") {
                        strong(title)
                    }
                case .Info:
                    div("card-header bg-info text-white") {
                        strong(title)
                    }
                case .Error:
                    div("card-header bg-error text-white") {
                        strong(title)
                    }
                case .Dark:
                    div("card-header bg-dark text-white") {
                        strong(title)
                    }
                case .Light:
                    div("card-header bg-light") {
                        strong(title)
                    }
                case .Success:
                    div("card-header bg-success text-white") {
                        strong(title)
                    }
                case .Warning:
                    div("card-header bg-warning text-white") {
                        strong(title)
                    }
                case .Basic:
                    div("card-header") {
                        strong(title)
                    }
                }
            }
            div("card-body") {
                body()
            }
        }
        
    }
    
}
