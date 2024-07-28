//
//  Theme.swift
//
//
//  Created by Adrian Herridge on 01/06/2024.
//

import Foundation

public protocol Theme {
    
    // Colors
    var primary: WebColor { get }
    var onPrimary: WebColor { get }
    var primaryContainer: WebColor { get }
    var onPrimaryContainer: WebColor { get }
    var inversePrimary: WebColor { get }
    var secondary: WebColor { get }
    var onSecondary: WebColor { get }
    var secondaryContainer: WebColor { get }
    var onSecondaryContainer: WebColor { get }
    var tertiary: WebColor { get }
    var onTertiary: WebColor { get }
    var tertiaryContainer: WebColor { get }
    var onTertiaryContainer: WebColor { get }
    var background: WebColor { get }
    var onBackground: WebColor { get }
    var surface: WebColor { get }
    var onSurface: WebColor { get }
    var surfaceVariant: WebColor { get }
    var onSurfaceVariant: WebColor { get }
    var inverseSurface: WebColor { get }
    var inverseOnSurface: WebColor { get }
    var error: WebColor { get }
    var onError: WebColor { get }
    var errorContainer: WebColor { get }
    var onErrorContainer: WebColor { get }
    var outline: WebColor { get }
    var outlineVariant: WebColor { get }
    var scrim: WebColor { get }
    var highlight: WebColor { get }
    var accent: WebColor { get }
    
    var fontFamily: String { get }
    
}
