//
//  File.swift
//  
//
//  Created by Adrian Herridge on 13/02/2023.
//

import Foundation

public enum ModalSize {
    case Small
    case Medium
    case Large
    case XLarge
}

public extension WebRequestContext {
    
    func modal(style: Style? = .Primary, 
               size: ModalSize? = .Medium,
               dialogTitle: String? = nil,
               buttonFace: WebComposerClosure? = nil,
               showClose: Bool? = true,
               id: String? = nil,
               noButton: Bool? = nil,
               _ content: WebComposerClosure) {
        
        let id = id ?? "modal\(UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: ""))"
        
        self.div("modal") {
            self.id(id)
            var modalClass = "modal-dialog"
            switch size {
            case .Small:
                modalClass += " modal-sm"
            case .Medium:
                break;
            case .Large:
                modalClass += " modal-lg"
            case .XLarge:
                modalClass += " modal-xl"
            case .none:
                break
            }
            self.div(modalClass) {
                self.div("modal-content") {
                    // header
                    self.div("modal-header") {
                        if let dialogTitle = dialogTitle {
                            self.h4(dialogTitle) {
                                self.class("modal-title")
                            }
                        }
                        self.text("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\"></button>")
                    }
                    self.div("modal-content") {
                        self.row(cls: "p-3 ms-3 me-3") {
                            content()
                        }
                    }
                    self.div("modal-footer") {
                        if let showClose = showClose, showClose {
                            self.text("<button type=\"button\" class=\"btn btn-secondary\" data-bs-dismiss=\"modal\">Close</button>")
                        }
                    }
                }
            }
        }
        /*
         <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">
             Open modal
           </button>
         */
        if let noButton = noButton, noButton {
            // create nothing
        } else {
            self.block("button") {
                self.class("btn btn-\(style?.rawValue ?? "primary")")
                self.type("button")
                self.property(property: "data-bs-toggle", value: "modal")
                self.property(property: "data-bs-target", value: "#\(id)")
                buttonFace?()
            }
        }
    }
    
    func modal(style: Style, size: ModalSize, title: String, showClose: Bool, id: String? = nil, noButton: Bool? = nil, _ content: WebComposerClosure) {
        let id = id ?? "modal\(UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: ""))"
        self.div("modal") {
            self.id(id)
            var modalClass = "modal-dialog"
            switch size {
            case .Small:
                modalClass += " modal-sm"
            case .Medium:
                break;
            case .Large:
                modalClass += " modal-lg"
            case .XLarge:
                modalClass += " modal-xl"
            }
            self.div(modalClass) {
                self.div("modal-content") {
                    // header
                    self.div("modal-header") {
                        self.h4(title) {
                            self.class("modal-title")
                        }
                        self.text("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\"></button>")
                    }
                    self.div("modal-content") {
                        content()
                    }
                    self.div("modal-footer") {
                        if showClose {
                            self.text("<button type=\"button\" class=\"btn btn-secondary\" data-bs-dismiss=\"modal\">Close</button>")
                        }
                    }
                }
            }
        }
        /*
         <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">
             Open modal
           </button>
         */
        if let noButton = noButton, noButton {
            // create nothing
        } else {
            self.button(style: style, title: title) {
                self.property(property: "data-bs-toggle", value: "modal")
                self.property(property: "data-bs-target", value: "#\(id)")
            }
        }
    }
    
}

public extension WebRequestContext {
    func modal(buttonTitle: String, title: String, style: Style, size: BootstrapSize, body: WebComposerIdentifiedClosure, footer: WebComposerClosure? = nil) {
        
        let id = "modal\(UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased())"
        
        // create the button
        /*
            <!-- Button to Open the Modal -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">
              Open modal
            </button>
         */
        
        var sz = ""
        switch size {
        case .large:
            sz = " modal-lg"
        case .default:
            sz = ""
        case .small:
            sz = " modal-sm"
        case .xlarge:
            sz = " modal-xl"
        case .xsmall:
            sz = " modal-xs"
        case .xxsmall:
            sz = " modal-xxs"
        }
        
        self.block("button") {
            self.type("button")
            self.class("btn btn-\(style.rawValue)")
            self.property(property: "data-bs-toggle", value: "modal")
            self.property(property: "data-bs-target", value: "#\(id)")
            self.text(buttonTitle)
        }
        
        self.div("modal fade") {
            self.id(id)
            self.div("modal-dialog" + sz) {
                self.div("modal-content") {
                    // <!-- Modal Header -->
                    self.div("modal-header") {
                        self.h4(title) {
                            self.class("modal-title")
                        }
                        self.block("button") {
                            self.class("btn-close")
                            self.property(property: "data-bs-dismiss", value: "modal")
                        }
                    }
                    
                    // <!-- Modal body -->
                    self.div("modal-body") {
                        body(id)
                    }
                    
                    if let footer = footer {
                        // <!-- Modal footer -->
                        self.div("modal-footer") {
                            footer()
                        }
                    }
                }
            }
            
        }

    }

}
