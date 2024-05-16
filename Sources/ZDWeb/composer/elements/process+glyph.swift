//
//  File.swift
//  
//
//  Created by Adrian Herridge on 02/07/2023.
//

import Foundation

public enum GlyphSize {
    
    case XXSmall
    case XSmall
    case Small
    case Medium
    case Large
    case XLarge
    case XXLarge
    case Jumbo
    
    var `class` : String {
        get {
            switch self {
            case .XXSmall:
                return " fa-xs"
            case .XSmall:
                return " fa-sm"
            case .Small:
                return " fa-lg"
            case .Medium:
                return " fa-2x"
            case .Large:
                return " fa-3x"
            case .XLarge:
                return " fa-5x"
            case .XXLarge:
                return " fa-7x"
            case .Jumbo:
                return " fa-10x"
            }
        }
    }
    
}

public enum GlyphWeight {
    case light
    case medium
    case bold
    
    var `class`: String {
        get {
            switch self {
            case .light:
                return "fal"
            case .medium:
                return "fa"
            case .bold:
                return "fab"
            }
        }
    }
}

public enum Glyph {
    
    case home(size: GlyphSize, weight: GlyphWeight)
    case browser(size: GlyphSize, weight: GlyphWeight)
    case collection(size: GlyphSize, weight: GlyphWeight)
    case chart(size: GlyphSize, weight: GlyphWeight)
    case invoice(size: GlyphSize, weight: GlyphWeight)
    
    var `class`: String {
        get {
            switch self {
            case .home(let size, let weight),
                    .collection(let size, let weight),
                    .browser(let size, let weight),
                    .chart(let size, let weight),
                    .invoice(let size, let weight):
                return "\(weight.class) \(self.faName) \(size.class)"
            }
        }
    }
    
    var faName : String {
        get {
            switch self {
            case .home:
                return "fa-home"
            case .browser:
                return "fa-browser"
            case .collection:
                return "fa-album-collection"
            case .chart:
                return "fa-chart-line"
            case .invoice:
                return "fa-file-invoice"
            }
        }
    }
    
}

public extension WebRequestContext {
    func glyph(_ glyph: Glyph, classes: [BootstrapClass]? = nil, style: String? = nil) {
        self.block("i") {
            if let style = style {
                self.style(.raw(value: style))
            }
            if let c = classes {
                self.class(c.map( { $0.rawValue} ).joined(separator: " ") + " " + glyph.class)
            } else {
                self.class(glyph.class)
            }
        }
    }
}
