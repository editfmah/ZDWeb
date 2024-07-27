//
//  Accordion.swift
//
//
//  Created by Adrian Herridge on 26/07/2024.
//

import Foundation

// adds specific conformance for all the generic properties, but also specific ones for an accordion
public class WebAccordionElement : WebCommonInterop, GenericAccordionProperties {}

// protocol of properties for an accordion
public protocol GenericAccordionProperties : GenericProperties {
    // define fluent methods for the accordion properties
    func alwaysOpen(_ alwaysOpen: Bool) -> Self
    func expandFirst(_ expandFirst: Bool) -> Self
}

// extension for the accordion properties
public extension GenericAccordionProperties {
    // implement fluent methods for the accordion properties
    @discardableResult
    func alwaysOpen(_ alwaysOpen: Bool) -> Self {
        script("\(builderId).classList.toggle('accordion-always-open', \(alwaysOpen));")
        return self
    }
    @discardableResult
    func expandFirst(_ expandFirst: Bool) -> Self {
        script("document.querySelector('#\(builderId) .accordion-item:first-child .accordion-collapse').classList.toggle('show', \(expandFirst));")
        return self
    }
}

public enum AccordionElement {
    case item(title: String, body: WebComposerClosure)
}

public class Accordion : WebAccordionElement {
    @discardableResult
    public init(_ elements: [AccordionElement]) {
        super.init()
        
        declare("div", identifier: "accordion " + self.builderId, id: self.builderId, {
            for (index, element) in elements.enumerated() {
                switch element {
                case .item(let title, let body):
                    let itemId = "\(self.builderId)-item-\(index)"
                    declare("div", identifier: "accordion-item", {
                        declare("h2", identifier: "accordion-header", attributes: ["id": "\(itemId)-header"], {
                            declare("button", identifier: "accordion-button collapsed", attributes: ["type": "button", "data-bs-toggle": "collapse", "data-bs-target": "#\(itemId)", "aria-expanded": "false", "aria-controls": itemId], {
                                context.text(title)
                            })
                        })
                        declare("div", identifier: "accordion-collapse collapse", attributes: ["id": itemId, "aria-labelledby": "\(itemId)-header", "data-bs-parent": "#\(self.builderId)"], {
                            declare("div", identifier: "accordion-body", {
                                body()
                            })
                        })
                    })
                }
            }
        })
        script("var \(builderId) = document.getElementById('\(builderId)');")
    }
}
