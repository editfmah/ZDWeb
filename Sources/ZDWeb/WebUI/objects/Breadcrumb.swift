//
//  Breadcrumb.swift
//
//
//  Created by Adrian Herridge on 29/07/2024.
//

import Foundation

public enum BreadcrumbItem {
    case item(title: String, url: String, icon: FontAwesomeIcon? = nil)
}

public protocol BreadcrumbProperties: GenericProperties {
    // Additional breadcrumb-specific properties can be added here if needed
}

public class Breadcrumb: WebElement, BreadcrumbProperties {
    @discardableResult
    public init(_ items: [BreadcrumbItem]) {
        super.init()

        declare("nav", classList: "breadcrumb-container \(self.builderId)", attributes: ["aria-label": "breadcrumb"]) {
            declare("ol", classList: "breadcrumb") {
                for item in items {
                    switch item {
                    case .item(let title, let url, let icon):
                        declare("li", classList: "breadcrumb-item") {
                            declare("a", classList: "", attributes: ["href": url]) {
                                if let icon = icon {
                                    Icon(icon)
                                }
                                context.text(title)
                            }
                        }
                    }
                }
            }
        }
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}
