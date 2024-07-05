//
//  File.swift
//  
//
//  Created by Adrian Herridge on 04/07/2024.
//

import Foundation

public class Modal : WebElement {
    @discardableResult
    public init(ref: String? = nil, _ body: WebComposerClosure) {
        super.init()
        executionPipeline()?.types[self.builderId] = .none
        
        // this is going to be a bootstrap modal with no header or footer and with the body closure as the body of the modal dialog
        
        // any headers and footers will be built into the body instead. This is to allow for more flexible modals
        executionPipeline()?.context?.declarative("div", identifier: self.builderId, {
            executionPipeline()?.context?.declarative("div", identifier: "modal-dialog modal-dialog-centered modal-fullscreen", {
                executionPipeline()?.context?.declarative("div", identifier: "modal-content", {
                    // now the header
                    executionPipeline()?.context?.declarative("div", identifier: "modal-header", {
                        executionPipeline()?.context?.text("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"modal\" aria-label=\"Close\"></button>")
                    })
                    // now the body
                    executionPipeline()?.context?.declarative("div", identifier: "modal-body", {
                        body()
                    })
                })
            })
        })
        
        // create the object links
        executionPipeline()?.context?.builderScript("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("modal")
        addClass("fade")
        if let ref = ref {
            self.ref(ref)
        }
        
    }
}
