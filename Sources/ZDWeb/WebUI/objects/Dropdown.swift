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

        declare("div", classList: "btn-group", id: self.builderId) {
            declare("button", classList: "btn btn-primary", attributes: ["type": "button"]) {
                context.text(title)
            }
            declare("button", classList: "btn btn-primary dropdown-toggle dropdown-toggle-split", attributes: ["type": "button", "data-bs-toggle": "dropdown", "aria-expanded": "false"]) {
                declare("span", classList: "visually-hidden") {
                    context.text("Toggle Dropdown")
                }
            }
            declare("ul", classList: "dropdown-menu") {
                for item in items {
                    switch item {
                    case .item(let title, let url, let icon, let disabled):
                        declare("li", classList: builderId) {
                            declare("a", classList: "dropdown-item" + (disabled == true ? " disabled" : ""), attributes: ["href": url ?? "#"]) {
                                if let icon = icon {
                                    Icon(icon)
                                        .color(.black) // Example: setting icon color, can be customized
                                }
                                context.text(title)
                            }
                        }
                    case .separator:
                        declare("li", classList: builderId) {
                            declare("hr", classList: "dropdown-divider") {
                                
                            }
                        }
                    }
                }
            }
        }
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}
