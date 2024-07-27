//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

import Foundation

public enum NavigationItem {
    case item(title: String, url: String? = nil, icon: FontAwesomeIcon? = nil, disabled: Bool? = nil, children: [NavigationItem]? = nil)
}


public protocol WebNavbarProperties: GenericProperties {
    @discardableResult
    func background(_ color: WebColor) -> Self
    
    @discardableResult
    func background(_ direction: WebGradientDirection, _ colors: [WebColor]) -> Self
    
    @discardableResult
    func theme(_ theme: NavbarTheme) -> Self
}

public enum NavbarTheme: String {
    case light = "navbar-light"
    case dark = "navbar-dark"
}

public enum NavigationAccessory {
    case search(placeholder: String? = nil, url: String? = nil, showAlways: Bool? = false)
}

public extension WebNavbarProperties {
    @discardableResult
    func background(_ color: WebColor) -> Self {
        script("""
        window.onload = function() {
            if (\(builderId)) {
                \(builderId).classList.remove('bg-light', 'bg-dark');
                \(builderId).style.backgroundColor = '\(color.rgba)';
            }
        };
        """)
        return self
    }

    @discardableResult
    func background(_ direction: WebGradientDirection, _ colors: [WebColor]) -> Self {
        script("""
        window.onload = function() {
            if (\(builderId)) {
                \(builderId).classList.remove('bg-light', 'bg-dark');
                \(builderId).style.backgroundImage = 'linear-gradient(\(direction.rawValue), \(colors.map({ $0.rgba }).joined(separator: ", ")))';
            }
        };
        """)
        return self
    }
    
    @discardableResult
    func theme(_ theme: NavbarTheme) -> Self {
        script("""
        window.onload = function() {
            if (\(builderId)) {
                \(builderId).classList.remove('navbar-light', 'navbar-dark');
                \(builderId).classList.add('\(theme.rawValue)');
            }
        };
        """)
        return self
    }
}


import Foundation

public class Navbar: WebElement, WebNavbarProperties {
    private var brandText: String?
    private var brandImage: String?
    private var items: [NavigationItem]
    private var accessories: [NavigationAccessory]?

    @discardableResult
    public init(brandText: String? = nil, brandImage: String? = nil, items: [NavigationItem], accessories: [NavigationAccessory]? = nil) {
        self.brandText = brandText
        self.brandImage = brandImage
        self.items = items
        self.accessories = accessories
        super.init()

        declare("nav", identifier: "navbar navbar-expand-lg navbar-light bg-light " + builderId) {
            declare("div", identifier: "container-fluid d-flex align-items-center justify-content-between " + builderId) {
                // Branding section
                declare("div", identifier: "navbar-brand-container d-flex align-items-center " + builderId) {
                    if let brandImage = brandImage, let brandText = brandText {
                        declare("a", identifier: "navbar-brand " + builderId, attributes: ["href": "#"]) {
                            declare("img", identifier: builderId, attributes: ["src": brandImage, "alt": brandText, "style": "height:30px; margin-right:10px;"]) {}
                            context.text(brandText)
                        }
                    } else if let brandImage = brandImage {
                        declare("a", identifier: "navbar-brand " + builderId, attributes: ["href": "#"]) {
                            declare("img", identifier: builderId, attributes: ["src": brandImage, "alt": brandText ?? "", "style": "height:30px;"]) {}
                        }
                    } else if let brandText = brandText {
                        declare("a", identifier: "navbar-brand " + builderId, attributes: ["href": "#"]) {
                            context.text(brandText)
                        }
                    }
                }

                // Navbar toggler for small screens
                declare("button", identifier: "navbar-toggler " + builderId, attributes: ["type": "button", "data-bs-toggle": "collapse", "data-bs-target": "#navbarNav", "aria-controls": "navbarNav", "aria-expanded": "false", "aria-label": "Toggle navigation"]) {
                    declare("span", identifier: "navbar-toggler-icon " + builderId) {}
                }

                // Navbar collapse
                declare("div", identifier: "collapse navbar-collapse " + builderId, id: "navbarNav") {
                    // Navigation items
                    declare("ul", identifier: "navbar-nav ms-auto mb-2 mb-lg-0 d-flex align-items-center " + builderId) {
                        for item in items {
                            renderNavigationItem(item)
                        }
                    }

                    // Accessories
                    if let accessories = accessories {
                        for accessory in accessories {
                            renderAccessory(accessory)
                        }
                    }
                }
            }
        }

        // Add CSS for hover dropdown
        let css = """
        .navbar-nav .dropdown:hover .dropdown-menu {
            display: block;
            margin-top: 0;
        }
        """
        declare("style", identifier: builderId) {
            context.text(css)
        }

        // Add JavaScript to handle hover events and initialize popover
        let js = """
        document.querySelectorAll('.navbar-nav .dropdown').forEach(function(dropdown) {
            dropdown.addEventListener('mouseover', function() {
                var dropdownMenu = this.querySelector('.dropdown-menu');
                if (dropdownMenu) {
                    dropdownMenu.classList.add('show');
                }
            });
            dropdown.addEventListener('mouseout', function() {
                var dropdownMenu = this.querySelector('.dropdown-menu');
                if (dropdownMenu) {
                    dropdownMenu.classList.remove('show');
                }
            });
        });

        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
        var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
          return new bootstrap.Popover(popoverTriggerEl, {
            html: true,
            content: function () {
              return document.getElementById('searchPopoverContent').innerHTML;
            }
          })
        })
        """
        script(js)

        script("var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }

    private func renderNavigationItem(_ item: NavigationItem) {
        switch item {
        case .item(let title, let url, let icon, let disabled, let children):
            if let children = children, !children.isEmpty {
                // Dropdown item
                declare("li", identifier: "nav-item dropdown " + builderId) {
                    declare("a", identifier: "nav-link dropdown-toggle" + (disabled == true ? " disabled" : "") + " " + builderId, attributes: ["href": url ?? "#", "id": "navbarDropdown", "role": "button", "data-bs-toggle": "dropdown", "aria-expanded": "false"]) {
                        if let icon = icon {
                            Icon(icon)
                        }
                        context.text(title)
                    }
                    declare("ul", identifier: "dropdown-menu " + builderId, attributes: ["aria-labelledby": "navbarDropdown"]) {
                        for child in children {
                            renderNavigationItem(child)
                        }
                    }
                }
            } else {
                // Simple item
                declare("li", identifier: "nav-item " + builderId) {
                    declare("a", identifier: "nav-link" + (disabled == true ? " disabled" : "") + " " + builderId, attributes: ["href": url ?? "#"]) {
                        if let icon = icon {
                            Icon(icon)
                        }
                        context.text(title)
                    }
                }
            }
        }
    }

    private func renderAccessory(_ accessory: NavigationAccessory) {
        switch accessory {
        case .search(let placeholder, let url, let showAlways):
            declare("div", identifier: "d-none", id: "searchPopoverContent") {
                declare("form", identifier: "d-flex align-items-center " + builderId) {
                    declare("input", identifier: "form-control me-2 " + builderId, attributes: ["type": "search", "placeholder": placeholder ?? "Search", "aria-label": "Search", "data-search-url": url ?? "#"]) {}
                    declare("button", identifier: "btn btn-outline-success " + builderId, attributes: ["type": "submit"]) {
                        context.text("Search")
                    }
                }
            }
            declare("button", identifier: "btn btn-outline-success search-toggle-button " + builderId, attributes: ["type": "button", "data-bs-toggle": "popover", "data-bs-placement": "bottom", "data-bs-trigger": "focus"]) {
                Icon(.search)
            }
        }
    }
}
