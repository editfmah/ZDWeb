//
//  File.swift
//  
//
//  Created by Adrian Herridge on 28/07/2024.
//

import Foundation

public extension GenericProperties {
    
    @discardableResult
        func applyTheme(_ theme: Theme) -> Self {
            script("""
                \(builderId).style.backgroundColor = '\(theme.background.rgba)';
                \(builderId).style.color = '\(theme.onBackground.rgba)';
            """)
            return self
        }

        @discardableResult
        func applyPrimaryTheme(_ theme: Theme) -> Self {
            script("""
                \(builderId).style.backgroundColor = '\(theme.primary.rgba)';
                \(builderId).style.color = '\(theme.onPrimary.rgba)';
            """)
            return self
        }

        @discardableResult
        func applySecondaryTheme(_ theme: Theme) -> Self {
            script("""
                \(builderId).style.backgroundColor = '\(theme.secondary.rgba)';
                \(builderId).style.color = '\(theme.onSecondary.rgba)';
            """)
            return self
        }

        @discardableResult
        func applyTertiaryTheme(_ theme: Theme) -> Self {
            script("""
                \(builderId).style.backgroundColor = '\(theme.tertiary.rgba)';
                \(builderId).style.color = '\(theme.onTertiary.rgba)';
            """)
            return self
        }

        @discardableResult
        func applyAccentTheme(_ theme: Theme) -> Self {
            script("""
                \(builderId).style.borderColor = '\(theme.accent.rgba)';
            """)
            return self
        }
    
}
