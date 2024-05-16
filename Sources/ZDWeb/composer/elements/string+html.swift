//
//  File.swift
//  
//
//  Created by Adrian Herridge on 10/08/2023.
//

import Foundation

public extension String {
    var small : String {
        get {
            return "<small>\(self)</small>"
        }
    }
    var italic : String {
        get {
            return "<i>\(self)</i>"
        }
    }
    var bold : String {
        get {
            return "<b>\(self)</b>"
        }
    }
}
