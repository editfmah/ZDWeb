//
//  Dropdown.swift
//
//
//  Created by Adrian Herridge on 27/07/2024.
//

import Foundation

public enum DropdownElement {
    case item(title: String, url: String? = nil, icon: FontAwesomeIcon? = nil, disabled: Bool? = nil)
    case separator
}

public class Dropdown: WebElement {
    private var title: String
    private var items: [DropdownElement]

    @discardableResult
    public init(_ title: String, items: [DropdownElement]) {
        self.title = title
        self.items = items
        super.init()

        declare("div", identifier: "btn-group", id: self.builderId) {
            declare("button", identifier: "btn btn-primary", attributes: ["type": "button"]) {
                context.text(title)
            }
            declare("button", identifier: "btn btn-primary dropdown-toggle dropdown-toggle-split", attributes: ["type": "button", "data-bs-toggle": "dropdown", "aria-expanded": "false"]) {
                declare("span", identifier: "visually-hidden") {
                    context.text("Toggle Dropdown")
                }
            }
            declare("ul", identifier: "dropdown-menu") {
                for item in items {
                    switch item {
                    case .item(let title, let url, let icon, let disabled):
                        declare("li", identifier: builderId) {
                            declare("a", identifier: "dropdown-item" + (disabled == true ? " disabled" : ""), attributes: ["href": url ?? "#"]) {
                                if let icon = icon {
                                    Icon(icon)
                                        .color(.black) // Example: setting icon color, can be customized
                                }
                                context.text(title)
                            }
                        }
                    case .separator:
                        declare("li", identifier: builderId) {
                            declare("hr", identifier: "dropdown-divider") {
                                
                            }
                        }
                    }
                }
            }
        }
        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}
