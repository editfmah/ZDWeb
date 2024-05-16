//
//  style+properties.swift
//  WebServer
//
//  Created by Adrian Herridge on 30/08/2021.
//

import Foundation

public enum StyleProperty {
    case width(value: Int)
    case height(value: Int)
    case widthpc(value: Int)
    case heightpc(value: Int)
    case raw(value: String)
    var compiled: String {
        get {
            switch self {
            case .width(let value):
                return "width: \(value)px; "
            case .height(let value):
                return "height: \(value)px; "
            case .widthpc(let value):
                return "width: \(value)%; "
            case .heightpc(let value):
                return "height: \(value)%; "
            case .raw(let value):
                return value
            }
        }
    }
    
}
