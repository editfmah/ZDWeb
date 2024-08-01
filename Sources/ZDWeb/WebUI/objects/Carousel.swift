//
//  carousel.swift
//
//
//  Created by Adrian Herridge on 25/07/2024.
//

import Foundation

// adds specific conformance for all the generic properties, but also specific ones for a carousel
public class WebCarouselElement : WebCommonInterop, GenericCarouselProperties {}

// protocol of properties for a carousel
public protocol GenericCarouselProperties : GenericProperties {
    // define fluent methods for the carousel properties
    func allowSwipe(_ swipe: Bool) -> Self
    func allowKeyboard(_ keyboard: Bool) -> Self
    func interval(_ interval: Int) -> Self
    func wrap(_ wrap: Bool) -> Self
    func jumpTo(_ index: Int) -> Self
}

// extension for the carousel properties
public extension GenericCarouselProperties {
    // implement fluent methods for the carousel properties
    @discardableResult
    func allowSwipe(_ swipe: Bool) -> Self {
        script("var carousel = bootstrap.Carousel.getInstance(document.getElementById('\(builderId)')); if (carousel) { carousel._config.touch = \(swipe); }")
        return self
    }
    @discardableResult
    func allowKeyboard(_ keyboard: Bool) -> Self {
        script("var carousel = bootstrap.Carousel.getInstance(document.getElementById('\(builderId)')); if (carousel) { carousel._config.keyboard = \(keyboard); }")
        return self
    }
    @discardableResult
    func interval(_ interval: Int) -> Self {
        script("var carousel = bootstrap.Carousel.getInstance(document.getElementById('\(builderId)')); if (carousel) { carousel._config.interval = \(interval); }")
        return self
    }
    @discardableResult
    func wrap(_ wrap: Bool) -> Self {
        script("var carousel = bootstrap.Carousel.getInstance(document.getElementById('\(builderId)')); if (carousel) { carousel._config.wrap = \(wrap); }")
        return self
    }
    @discardableResult
    func jumpTo(_ index: Int) -> Self {
        script("var carousel = bootstrap.Carousel.getInstance(document.getElementById('\(builderId)')); if (carousel) { carousel.to(\(index)); }")
        return self
    }
}

public enum CarouselElement {
    case item(title: String? = nil, subtitle: String? = nil, body: WebComposerClosure, indicator: WebComposerClosure? = nil)
}

public class Carousel : WebCarouselElement {
    @discardableResult
    public init(_ elements: [CarouselElement]) {
        super.init()
        
        declare("div", classList: "carousel slide " + self.builderId, id: self.builderId, {
            // build the indicators
            declare("div", classList: "carousel-indicators") {
                for (index, e) in elements.enumerated() {
                    switch e {
                    case .item(_, _, _, let indicatorBody):
                        declare("button", classList: index == 0 ? "active" : "", attributes: ["data-bs-target":"#\(self.builderId)", "data-bs-slide-to":"\(index)", "aria-current":"true", "aria-label":"Slide \(index + 1)"], {
                            indicatorBody?() ?? context.text("\(index + 1)")
                        })
                    }
                }
            }
            
            declare("div", classList: "carousel-inner") {
                for (index, e) in elements.enumerated() {
                    switch e {
                    case .item(let title, let subtitle, let body, _):
                        declare("div", classList: "carousel-item \(index == 0 ? "active" : "")", {
                            body()
                            if title != nil || subtitle != nil {
                                declare("div", classList: "carousel-caption") {
                                    if let title = title {
                                        declare("h5", classList: "", {
                                            context.text(title)
                                        })
                                    }
                                    if let subtitle = subtitle {
                                        declare("p", classList: "", {
                                            context.text(subtitle)
                                        })
                                    }
                                }
                            }
                        })
                    }
                }
            }
            
            declare("button", classList: "carousel-control-prev", attributes: ["type":"button", "data-bs-target":"#\(self.builderId)", "data-bs-slide":"prev"]) {
                declare("span", classList: "carousel-control-prev-icon", attributes: ["aria-hidden":"true"]) {
                }
                declare("span", classList: "visually-hidden") {
                    context.text("Previous")
                }
            }
            
            declare("button", classList: "carousel-control-next", attributes: ["type":"button", "data-bs-target":"#\(self.builderId)", "data-bs-slide":"next"]) {
                declare("span", classList: "carousel-control-next-icon", attributes: ["aria-hidden":"true"]) {
                }
                declare("span", classList: "visually-hidden") {
                    context.text("Next")
                }
            }
            
        })
        script("/* builder-object-reference */ var \(builderId) = new bootstrap.Carousel(document.getElementById('\(builderId)'));")
    }
}
