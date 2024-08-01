//
//  File.swift
//  
//
//  Created by Adrian Herridge on 29/07/2024.
//

import Foundation

public enum FlexOption: String {
    // Flex direction
    case row = "flex-row"
    case rowReverse = "flex-row-reverse"
    case column = "flex-column"
    case columnReverse = "flex-column-reverse"

    // Flex wrap
    case wrap = "flex-wrap"
    case nowrap = "flex-nowrap"
    case wrapReverse = "flex-wrap-reverse"

    // Justify content
    case justifyContentStart = "justify-content-start"
    case justifyContentEnd = "justify-content-end"
    case justifyContentCenter = "justify-content-center"
    case justifyContentBetween = "justify-content-between"
    case justifyContentAround = "justify-content-around"
    case justifyContentEvenly = "justify-content-evenly"

    // Align items
    case alignItemsStart = "align-items-start"
    case alignItemsEnd = "align-items-end"
    case alignItemsCenter = "align-items-center"
    case alignItemsBaseline = "align-items-baseline"
    case alignItemsStretch = "align-items-stretch"

    // Align self
    case alignSelfStart = "align-self-start"
    case alignSelfEnd = "align-self-end"
    case alignSelfCenter = "align-self-center"
    case alignSelfBaseline = "align-self-baseline"
    case alignSelfStretch = "align-self-stretch"

    // Align content
    case alignContentStart = "align-content-start"
    case alignContentEnd = "align-content-end"
    case alignContentCenter = "align-content-center"
    case alignContentBetween = "align-content-between"
    case alignContentAround = "align-content-around"
    case alignContentStretch = "align-content-stretch"

    // Order
    case orderFirst = "order-first"
    case orderLast = "order-last"
    case orderNone = "order-none"
    case order1 = "order-1"
    case order2 = "order-2"
    case order3 = "order-3"
    case order4 = "order-4"
    case order5 = "order-5"
    case order6 = "order-6"
    case order7 = "order-7"
    case order8 = "order-8"
    case order9 = "order-9"
    case order10 = "order-10"
    case order11 = "order-11"
    case order12 = "order-12"
}


public protocol WebFlexProperties: GenericProperties {
    @discardableResult
    func flexDirection(_ direction: FlexOption) -> Self

    @discardableResult
    func flexWrap(_ wrap: FlexOption) -> Self

    @discardableResult
    func justifyContent(_ justify: FlexOption) -> Self

    @discardableResult
    func alignItems(_ align: FlexOption) -> Self

    @discardableResult
    func alignSelf(_ align: FlexOption) -> Self

    @discardableResult
    func alignContent(_ align: FlexOption) -> Self

    @discardableResult
    func order(_ order: FlexOption) -> Self
}

public extension WebFlexProperties {
    @discardableResult
    func flexDirection(_ direction: FlexOption) -> Self {
        script("\(builderId).classList.add('\(direction.rawValue)');")
        return self
    }

    @discardableResult
    func flexWrap(_ wrap: FlexOption) -> Self {
        script("\(builderId).classList.add('\(wrap.rawValue)');")
        return self
    }

    @discardableResult
    func justifyContent(_ justify: FlexOption) -> Self {
        script("\(builderId).classList.add('\(justify.rawValue)');")
        return self
    }

    @discardableResult
    func alignItems(_ align: FlexOption) -> Self {
        script("\(builderId).classList.add('\(align.rawValue)');")
        return self
    }

    @discardableResult
    func alignSelf(_ align: FlexOption) -> Self {
        script("\(builderId).classList.add('\(align.rawValue)');")
        return self
    }

    @discardableResult
    func alignContent(_ align: FlexOption) -> Self {
        script("\(builderId).classList.add('\(align.rawValue)');")
        return self
    }

    @discardableResult
    func order(_ order: FlexOption) -> Self {
        script("\(builderId).classList.add('\(order.rawValue)');")
        return self
    }
}

public class Flex: WebElement, WebFlexProperties {
    @discardableResult
    public init(_ options: [FlexOption] = [], _ body: WebComposerClosure) {
        super.init()
        
        let flexClasses = options.map { $0.rawValue }.joined(separator: " ")
        declare("div", classList: "d-flex \(flexClasses) \(self.builderId)") {
            body()
        }
        script("/* builder-object-reference */ var \(builderId) = document.getElementsByClassName('\(builderId)')[0];")
    }
}
