//
//  File.swift
//  
//
//  Created by Adrian Herridge on 04/11/2022.
//

import Foundation

public class ParameterDecodingObject : Codable {
    public init(){}
    public var account: UUID?
    public var resource: UUID?
    public var user: UUID?
    public var sub: UUID?
    public var version: UUID?
    public var filter: String?
    public var action: String?
    public var fragment: String?
}
