//
//  File.swift
//
//
//  Created by Adrian Herridge on 04/07/2024.
//

import Foundation

/*
 
 Size     Class     Modal max-width
 Small     .modal-sm     300px
 Default     None     500px
 Large     .modal-lg     800px
 Extra large     .modal-xl     1140px
 
 */

public enum WebModalType: String {
    case fullScreen = "modal-fullscreen"
    case small = "modal-sm"
    case large = "modal-lg"
    case extraLarge = "modal-xl"
    case unknown = ""
}

public class Modal : WebElement {
    @discardableResult
    public init(type: WebModalType? = .fullScreen, title: String? = nil,  ref: String? = nil, _ body: WebComposerClosure) {
        super.init()
        self.type = .unknown
        
        // this is going to be a bootstrap modal with no header or footer and with the body closure as the body of the modal dialog
        
        // any headers and footers will be built into the body instead. This is to allow for more flexible modals
        declare("div", classList: self.builderId, {
            declare("div", classList: "modal-dialog modal-dialog-centered \(type?.rawValue ?? "")", {
                declare("div", classList: "modal-content", {
                    // now the header
                    declare("div", classList: "modal-header", {
                        context.text("<h5 class=\"modal-title\">\(title ?? "")</h5>")
                        context.text("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>")
                    })
                    // now the body
                    declare("div", classList: "modal-body", {
                        body()
                    })
                })
            })
        })
        
        // create the object links
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("modal")
        addClass("fade")
        if let ref = ref {
            self.ref(ref)
        }
        
    }
}
