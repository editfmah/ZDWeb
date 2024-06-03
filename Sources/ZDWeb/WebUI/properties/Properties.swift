//
//  GenericProperties.swift
//
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

public enum Operator {
    
    case equals(Any)
    case isEmpty
    case isZero
    case isNonzero
    case isNotEmpty
    case isTrue
    case isFalse
    case isPositive
    case isNegative
    
    var javascriptCondition: String {
        get {
            switch self {
            case .equals(let comparitor):
                if let stringValue = comparitor as? String {
                    return "== '\(stringValue)'"
                } else if let intValue = comparitor as? Int {
                    return "== \(intValue)"
                } else if let doubleValue = comparitor as? Double {
                    return "== \(doubleValue)"
                } else if let boolValue = comparitor as? Bool {
                    return "== \(boolValue ? "true" : "false")"
                } else {
                    return "== '\(comparitor)'"
                }
            case .isEmpty:
                return "== ''"
            case .isNotEmpty:
                return "!= ''"
            case .isTrue:
                return "== true"
            case .isFalse:
                return "== false"
            case .isZero:
                return "== 0"
            case .isNonzero:
                return "!= 0"
            case .isPositive:
                return "> 0"
            case .isNegative:
                return "< 0"
            }
        }
    }
    
}

public enum WebAreaPosition {
    case leading
    case trailing
    case top
    case bottom
    case all
}

public enum WebCornerPosition : String {
    case topLeft = "TopLeft"
    case topRight = "TopRight"
    case bottomLeft = "BottomLeft"
    case bottomRight = "BottomRight"
}

public enum WebFontSize {
    case veryLargeTitle
    case largeTitle
    case title
    case title2
    case normal
    case subtitle
    case caption
    case footnote
    case custom(_ size: Int)
}

public enum WebOpacity {
    
    case opaque
    case semiOpaque
    case semiTransparent
    case nearTransparent
    case clear
    
    var bsValue: String {
        switch self {
        case .opaque:
            return "100"
        case .semiOpaque:
            return "75"
        case .semiTransparent:
            return "50"
        case .nearTransparent:
            return "25"
        case .clear:
            return "0"
        }
    }
    
    var cssValue: String {
        switch self {
        case .opaque:
            return "1"
        case .semiOpaque:
            return "0.75"
        case .semiTransparent:
            return "0.5"
        case .nearTransparent:
            return "0.25"
        case .clear:
            return "0"
        }
    }
    
}

public enum WebColor {
    
    case red
    case darkred
    case lightred
    case green
    case lightgreen
    case darkgreen
    case blue
    case lightblue
    case darkblue
    case yellow
    case lightyellow
    case darkyellow
    case orange
    case lightorange
    case darkorange
    case purple
    case lightpurple
    case darkpurple
    case pink
    case lightpink
    case darkpink
    case brown
    case lightbrown
    case darkbrown
    case grey
    case darkGrey
    case lightGrey
    case indigo
    case lightindigo
    case darkindigo
    case teal
    case lightteal
    case darkteal
    case cyan
    case lightcyan
    case darkcyan
    case black
    case white
    case transparent
    case custom(_ hexColor: String)
    
    var bsColor: String {
        switch self {
        case .red,. darkred, .lightred:
            return "danger"
        case .green, .lightgreen, .darkgreen:
            return "success"
        case .blue, .lightblue, .darkblue:
            return "primary"
        case .yellow, .lightyellow, .darkyellow:
            return "warning"
        case .orange, .lightorange, .darkorange:
            return "warning"
        case .purple, .lightpurple, .darkpurple:
            return "info"
        case .pink, .lightpink, .darkpink:
            return "danger"
        case .brown, .lightbrown, .darkbrown:
            return "secondary"
        case .grey:
            return "secondary"
        case .lightGrey:
            return "light"
        case .darkGrey:
            return "dark"
        case .indigo, .lightindigo, .darkindigo:
            return "primary"
        case .teal, .lightteal, .darkteal:
            return "info"
        case .cyan, .lightcyan, .darkcyan:
            return "info"
        case .black:
            return "dark"
        case .white:
            return "white"
        case .transparent:
            return "transparent"
        case .custom(_):
            return "custom"
        }
    }
    
    var rgba: String {
        switch self {
        case .red:
            return "rgba(255,0,0,1)"
        case .darkred:
            return "rgba(139,0,0,1)"
        case .lightred:
            return "rgba(255,102,102,1)"
        case .green:
            return "rgba(0,128,0,1)"
        case .lightgreen:
            return "rgba(102,255,102,1)"
        case .darkgreen:
            return "rgba(0,100,0,1)"
        case .blue:
            return "rgba(0,0,255,1)"
        case .lightblue:
            return "rgba(102,102,255,1)"
        case .darkblue:
            return "rgba(0,0,139,1)"
        case .yellow:
            return "rgba(255,255,0,1)"
        case .lightyellow:
            return "rgba(255,255,102,1)"
        case .darkyellow:
            return "rgba(255,255,0,1)"
        case .orange:
            return "rgba(255,165,0,1)"
        case .lightorange:
            return "rgba(255,204,153,1)"
        case .darkorange:
            return "rgba(255,140,0,1)"
        case .purple:
            return "rgba(128,0,128,1)"
        case .lightpurple:
            return "rgba(204,153,255,1)"
        case .darkpurple:
            return "rgba(75,0,130,1)"
        case .pink:
            return "rgba(255,192,203,1)"
        case .lightpink:
            return "rgba(255,204,204,1)"
        case .darkpink:
            return "rgba(255,105,180,1)"
        case .brown:
            return "rgba(165,42,42,1)"
        case .lightbrown:
            return "rgba(210,180,140,1)"
        case .darkbrown:
            return "rgba(139,69,19,1)"
        case .grey:
            return "rgba(128,128,128,1)"
        case .darkGrey:
            return "rgba(64,64,64,1)"
        case .lightGrey:
            return "rgba(192,192,192,1)"
        case .indigo:
            return "rgba(75,0,130,1)"
        case .lightindigo:
            return "rgba(153,102,255,1)"
        case .darkindigo:
            return "rgba(75,0,130,1)"
        case .teal:
            return "rgba(0,128,128,1)"
        case .lightteal:
            return "rgba(102,255,255,1)"
        case .darkteal:
            return "rgba(0,139,139,1)"
        case .cyan:
            return "rgba(0,255,255,1)"
        case .lightcyan:
            return "rgba(102,255,255,1)"
        case .darkcyan:
            return "rgba(0,139,139,1)"
        case .black:
            return "rgba(0,0,0,1)"
        case .white:
            return "rgba(255,255,255,1)"
        case .transparent:
            return "rgba(0,0,0,0)"
        case .custom(let colorString):
            return colorString
        }
        
    }
}

public enum WebMarginType {
    case auto
    case none
}

public enum WebTextAlignment: String {
    case left
    case right
    case center
    case justify
}

public enum WebContentAlignment : String {
    case start
    case end
    case center
    case between
    case around
    case evenly
}

public protocol GenericProperties {
    
    var builderId: String { get }
    
    // property setters
    func background(_ color: WebColor) -> Self
    func font(_ font: WebFontSize) -> Self
    func bold() -> Self
    func lightweight() -> Self
    func italic() -> Self
    func strikethrough() -> Self
    func underline(_ value: Bool) -> Self
    func padding(_ padding: Int) -> Self
    func padding(_ position: WebAreaPosition, _ padding: Int) -> Self
    func padding(_ positions: [WebAreaPosition], _ padding: Int) -> Self
    func margin(_ margin: Int) -> Self
    func margin(_ position: WebAreaPosition, _ margin: Int) -> Self
    func margin(_ positions: [WebAreaPosition], _ margin: Int) -> Self
    func radius(_ radius: Int) -> Self
    func radius(_ position: WebCornerPosition, _ radius: Int) -> Self
    func radius(_ positions: [WebCornerPosition], _ radius: Int) -> Self
    func shadow(_ shadow: Int) -> Self
    func border(_ color: WebColor, width: Int) -> Self
    func width(_ width: Int) -> Self
    func height(_ height: Int) -> Self
    func maxWidth(_ width: Int) -> Self
    func minWidth(_ width: Int) -> Self
    func maxHeight(_ height: Int) -> Self
    func minHeight(_ height: Int) -> Self
    func textalign(_ align: WebTextAlignment) -> Self
    func foreground(_ color: WebColor) -> Self
    func fontfamily(_ family: String) -> Self
    func opacity(_ opacity: Double) -> Self
    func name(_ name: String) -> Self
    func value(_ value: String) -> Self
    func ref(_ id: String) -> Self
    func hidden(_ hidden: WBool) -> Self
    func hidden(_ variable: WebVariable,_ operator: Operator) -> Self
    func enabled(_ enabled: WBool) -> Self
    func enabled(_ variable: WebVariable,_ operator: Operator) -> Self
    func margin(_ marginType: WebMarginType) -> Self
    func justifyContent(_ justify: WebContentAlignment) -> Self
    func verticalAlignContent(_ align: WebContentAlignment) -> Self
    
    // common events
    func onClick(_ action: WebAction) -> Self
    func onClick(_ actions: [WebAction]) -> Self
    func onMouseover(_ action: WebAction) -> Self
    func onMouseover(_ actions: [WebAction]) -> Self
    func onMouseLeave(_ action: WebAction) -> Self
    func onMouseLeave(_ actions: [WebAction]) -> Self
    func onEnable(_ action: WebAction) -> Self
    func onEnable(_ actions: [WebAction]) -> Self
    func onDisable(_ action: WebAction) -> Self
    func onDisable(_ actions: [WebAction]) -> Self
}

public protocol ImageProperties : GenericProperties {
    func src(_ src: String) -> Self
    func alt(_ alt: String) -> Self
    func scaleToFit() -> Self
    func scaleToFill() -> Self
}

public protocol GenericFormProperties : GenericProperties {
    func target(_ url: String) -> Self
}

public enum WebButtonType : String {
    case button
    case submit
    case reset
}

public enum WebStyle : String {
    
    case primary
    case secondary
    case success
    case danger
    case warning
    case info
    case light
    case dark
    case link
    case transparent
    
    static var all: [WebStyle] {
        return [.primary, .secondary, .success, .danger, .warning, .info, .light, .dark, .link, .transparent]
    }
    
    var textStyleClass: String {
        switch self {
        case .primary:
            return "text-primary"
        case .secondary:
            return "text-secondary"
        case .success:
            return "text-success"
        case .danger:
            return "text-danger"
        case .warning:
            return "text-warning"
        case .info:
            return "text-info"
        case .light:
            return "text-light"
        case .dark:
            return "text-dark"
        case .link:
            return "text-link"
        case .transparent:
            return "text-transparent"
        }
    }
    
    var buttonStyleClass: String {
        switch self {
        case .primary:
            return "btn-primary"
        case .secondary:
            return "btn-secondary"
        case .success:
            return "btn-success"
        case .danger:
            return "btn-danger"
        case .warning:
            return "btn-warning"
        case .info:
            return "btn-info"
        case .light:
            return "btn-light"
        case .dark:
            return "btn-dark"
        case .link:
            return "btn-link"
        case .transparent:
            return "btn-transparent"
        }
    }
    
    var linkStyleClass: String {
        switch self {
        case .primary:
            return "link-primary"
        case .secondary:
            return "link-secondary"
        case .success:
            return "link-success"
        case .danger:
            return "link-danger"
        case .warning:
            return "link-warning"
        case .info:
            return "link-info"
        case .light:
            return "link-light"
        case .dark:
            return "link-dark"
        case .link:
            return "link-link"
        case .transparent:
            return "link-transparent"
        }
    }
}

public protocol GenericButtonProperties : GenericProperties {
    func type(_ type: WebButtonType) -> Self
    func style(_ style: WebStyle) -> Self
    func conditions(_ conditions: [WebVariable]) -> Self
}
