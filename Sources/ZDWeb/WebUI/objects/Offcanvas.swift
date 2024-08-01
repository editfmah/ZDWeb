//
//  File.swift
//  
//
//  Created by Adrian Herridge on 27/07/2024.
//

import Foundation

public protocol WebCanvasProperties: GenericProperties {
    @discardableResult
    func backdrop(_ show: Bool) -> Self
    
    @discardableResult
    func scroll(_ enable: Bool) -> Self
    
    @discardableResult
    func placement(_ position: OffCanvasPlacement) -> Self
}

public enum OffCanvasPlacement: String {
    case start = "offcanvas-start"
    case end = "offcanvas-end"
    case top = "offcanvas-top"
    case bottom = "offcanvas-bottom"
}

public extension WebCanvasProperties {
    @discardableResult
    func backdrop(_ show: Bool) -> Self {
        script("""
        if (\(builderId)) {
            \(builderId).setAttribute('data-bs-backdrop', '\(show ? "true" : "false")');
        }
        """)
        return self
    }

    @discardableResult
    func scroll(_ enable: Bool) -> Self {
        script("""
        if (\(builderId)) {
            \(builderId).setAttribute('data-bs-scroll', '\(enable ? "true" : "false")');
        }
        """)
        return self
    }

    @discardableResult
    func placement(_ position: OffCanvasPlacement) -> Self {
        script("""
        if (\(builderId)) {
            \(builderId).classList.remove('offcanvas-start', 'offcanvas-end', 'offcanvas-top', 'offcanvas-bottom');
            \(builderId).classList.add('\(position.rawValue)');
        }
        """)
        return self
    }
}

public class OffCanvas: WebElement, WebCanvasProperties {
    @discardableResult
    public init(title: String? = nil, ref: String? = nil, _ body: WebComposerClosure) {
        super.init()
        
        // this is going to be a bootstrap off-canvas with the body closure as the body of the off-canvas
        
        declare("div", classList: self.builderId, {
            declare("div", classList: "offcanvas-header", {
                context.text("<h5 class=\"offcanvas-title\">\(title ?? "")</h5>")
                context.text("<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"offcanvas\" aria-label=\"Close\"></button>")
            })
            // now the body
            declare("div", classList: "offcanvas-body", {
                body()
            })
        })
        
        // create the object links
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
        addClass("offcanvas")
        if let ref = ref {
            self.ref(ref)
        }
    }
}

// Example usage
let offCanvas = OffCanvas(title: "OffCanvas Title") {
    Text("This is the body of the off-canvas.")
}.placement(.end).backdrop(true).scroll(false)

