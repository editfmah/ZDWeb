//
//  Theme.swift
//  
//
//  Created by Adrian Herridge on 01/06/2024.
//

import Foundation

public protocol Theme {
    
    var fontFamily: String { get }
    var accentColor: WebColor { get }
    
    // the page itself
    var pageBackgroundColor: WebColor { get }
    var pageTextColor: WebColor { get }
    var pageLinkColor: WebColor { get }
    
    // menu container
    var menuContainerBackgroundColor: WebColor { get }
    var menuContainerTextColor: WebColor { get }
    var menuItemColor: WebColor { get }
    var menuItemHoverColor: WebColor { get }
    var menuItemHoverUnderlineColor: WebColor { get }
    var menuItemActiveColor: WebColor { get }
    var menuItemActiveUnderlineColor: WebColor { get }
    var menuLogoURL: String { get }
    
    // primary container
    var primaryContainer: WebColor { get }
    var onPrimaryContainer: WebColor { get }
    var onPrimaryContainerLink: WebColor { get }
    var rimaryContainerHeader: WebColor { get }
    var onPrimaryContainerHeader: WebColor { get }
    var primaryContainerFooter: WebColor { get }
    var onPrimaryContainerFooter: WebColor { get }
    
    // secondary container
    var secondaryContainer: WebColor { get }
    var onSecondaryContainer: WebColor { get }
    var onSecondaryContainerLink: WebColor { get }
    var secondaryContainerHeader: WebColor { get }
    var onSecondaryContainerHeader: WebColor { get }
    var secondaryContainerFooter: WebColor { get }
    var onSecondaryContainerFooter: WebColor { get }
    
    // tertiary container
    var tertiaryContainer: WebColor { get }
    var onTertiaryContainer: WebColor { get }
    var onTertiaryContainerLink: WebColor { get }
    var tertiaryContainerHeader: WebColor { get }
    var onTertiaryContainerHeader: WebColor { get }
    var tertiaryContainerFooter: WebColor { get }
    var onTertiaryContainerFooter: WebColor { get }
    
}
