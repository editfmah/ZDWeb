//
//  Properties+Form.swift
//
//
//  Created by Adrian Herridge on 17/05/2024.
//

import Foundation

public enum WebFormMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum WebFormEnctype : String {
    case applicationXWWWFormUrlencoded = "application/x-www-form-urlencoded"
    case multipartFormData = "multipart/form-data"
    case textPlain = "text/plain"
}

public enum WebFormAction : String {
    case submit = "submit"
    case reset = "reset"
}

public extension GenericFormProperties {
    @discardableResult
    func action(_ action: WebFormAction) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).action = '\(action)';")
        return self
    }
    
    @discardableResult
    func method(_ method: WebFormMethod) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).method = '\(method)';")
        return self
    }
    
    @discardableResult
    func enctype(_ enctype: WebFormEnctype) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).enctype = '\(enctype)';")
        return self
    }
    
    @discardableResult
    func target(_ target: String) -> Self {
        executionPipeline()?.context?.builderScript("\(builderId).target = '\(target)';")
        return self
    }
    
}
