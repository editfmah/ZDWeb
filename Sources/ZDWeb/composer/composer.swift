//
//  File.swift
//  
//
//  Created by Adrian Herridge on 29/08/2021.
//

import Foundation

public typealias WebComposerClosure = () -> Void
public typealias WebComposerIdentifiedClosure = (_ id: String) -> Void
public typealias WebComposerContextClosure = (_ c: WebRequestContext) -> Void

public enum BootstrapSize : String {
    case large = "lg"
    case `default` = "def"
    case small = "sm"
    case xlarge = "xl"
    case xsmall = "xs"
    case xxsmall = "xxs"
}
