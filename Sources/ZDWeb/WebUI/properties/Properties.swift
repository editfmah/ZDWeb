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
    case isNotEmpty
    case isTrue
    case isFalse
}

public enum WebAreaPosition {
    case leading
    case trailing
    case top
    case bottom
    case all
}

public enum WebFont {
    case largeTitle
    case title
    case title2
    case normal
    case subtitle
    case caption
    case footnote
}

public enum WebColor {
    
    case red
    case green
    case blue
    case yellow
    case orange
    case purple
    case pink
    case brown
    case grey
    case darkGrey
    case lightGrey
    case black
    case white
    case transparent
    
    var rgba: String {
        switch self {
        case .red:
            return "rgba(255,0,0,1)"
        case .green:
            return "rgba(0,255,0,1)"
        case .blue:
            return "rgba(0,0,255,1)"
        case .yellow:
            return "rgba(255,255,0,1)"
        case .orange:
            return "rgba(255,165,0,1)"
        case .purple:
            return "rgba(128,0,128,1)"
        case .pink:
            return "rgba(255,192,203,1)"
        case .brown:
            return "rgba(165,42,42,1)"
        case .grey:
            return "rgba(128,128,128,1)"
        case .black:
            return "rgba(0,0,0,1)"
        case .white:
            return "rgba(255,255,255,1)"
        case .transparent:
            return "rgba(0,0,0,0)"
        case .darkGrey:
            return "rgba(169,169,169,1)"
        case .lightGrey:
            return "rgba(211,211,211,1)"
        }
    }
    
}

public protocol GenericProperties {
    var builderId: String { get }
    func background(_ color: WebColor) -> Self
    func font(_ font: WebFont) -> Self
    func padding(_ padding: Int) -> Self
    func padding(_ position: WebAreaPosition, _ padding: Int) -> Self
    func padding(_ positions: [WebAreaPosition], _ padding: Int) -> Self
    func margin(_ margin: Int) -> Self
    func margin(_ position: WebAreaPosition, _ margin: Int) -> Self
    func margin(_ positions: [WebAreaPosition], _ margin: Int) -> Self
    func radius(_ radius: Int) -> Self
    func shadow(_ shadow: Int) -> Self
    func border(_ color: WebColor, width: Int) -> Self
    func width(_ width: Int) -> Self
    func height(_ height: Int) -> Self
    func foreground(_ color: WebColor) -> Self
    func fontfamily(_ family: String) -> Self
    func opacity(_ opacity: Double) -> Self
    func name(_ name: String) -> Self
    func value(_ value: String) -> Self
    func id(_ id: String) -> Self
    func hidden(_ hidden: WBool) -> Self
    func hidden(_ variable: WebVariable,_ operator: Operator) -> Self
    func onClick(toggle: WBool) -> Self
    func onClick(script: String) -> Self
}

public protocol ImageProperties : GenericProperties {
    func src(_ src: String) -> Self
    func alt(_ alt: String) -> Self
    func scaleToFit() -> Self
    func scaleToFill() -> Self
}
