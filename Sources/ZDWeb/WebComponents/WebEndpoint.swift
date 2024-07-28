//
//  WebEndpoint.swift
//  WebServer
//
//  Created by Adrian Herridge on 29/08/2021.
//

import Foundation

public enum AuthenticationStatus {
    case authenticated
    case unauthenticated
}

public protocol WebResponseObject {
    func httpResponse() -> HttpResponse
}

extension WebRequestContext : WebResponseObject {
    public func httpResponse() -> HttpResponse {
        return .ok(.html(body), self.security.token)
    }
}

extension HttpResponse : WebResponseObject {
    public func httpResponse() -> HttpResponse {
        return self
    }
}

public protocol WebAPIObject {
    var metadata: [String:String] { get set }
}

public protocol WebEndpoint {
    static func register()
    var controller: String? { get }
    var method: String? { get }
    var accessible: [AuthenticationStatus] { get }
}

public protocol WebAPIEndpoint : WebEndpoint {
    var grants: [String] { get }
    func call(_ c: WebRequestContext, data: WebRequestData) -> WebResponseObject?
}

public protocol WebFunction : WebAPIEndpoint {
    var function: String { get }
}

public protocol MenuIndexable {
    var icon: FontAwesomeIcon? { get }
    var menuEntry: (primary: String, secondary: String?)? { get }
}

public protocol WebHTMLEndpoint : WebEndpoint {
    
    var initialEndpoint: Bool { get }
    var title: String { get }
    var grants: [WebNavigationActivity:[String]] { get }
    
    // shows the content of a controller
    func content(_ c: WebRequestContext) -> WebResponseObject?
    
    // views a resource of a controller
    func view(_ c: WebRequestContext) -> WebResponseObject?
    
    // modifies content of a resource for this controller
    func modify(_ c: WebRequestContext) -> WebResponseObject?
    
    // creates a new resource for controller
    func new(_ c: WebRequestContext) -> WebResponseObject?
    
    // saves resource for controller, returns a http response directly for redirects etc...
    func save(_ c: WebRequestContext, data: WebRequestData) -> WebResponseObject?
    
    // deletes a resource and cleans up the relationships
    func delete(_ c: WebRequestContext) -> WebResponseObject?
    
    // raw object getter
    func raw(_ c: WebRequestContext) -> WebResponseObject?
    
    // fragment object getter
    func fragment(_ c: WebRequestContext, activity: WebNavigationActivity,  fragment: String) -> WebResponseObject?
    
}

public extension WebHTMLEndpoint {
    
    var path: String {
        get {
            var path = "/"
            if let controller = self.controller {
                path += controller
            }
            if let method = self.method {
                path += "/"
                path += method
            }
            return path
        }
    }
    
}

// isSubset
public extension Array where Element: StringProtocol {
    func isSubsetOf(_ array: [String]) -> Bool {
        let thisSet = Set(self.compactMap({ $0 as? String }))
        let thatSet = Set(array)
        return thisSet.isSubset(of: thatSet)
    }
    func contains(_ array: [String]) -> Bool {
        let thisSet = Set(self.compactMap({ $0 as? String }))
        let thatSet = Set(array)
        return thatSet.isSubset(of: thisSet)
    }
    func containsAnyOf(_ array: [String]) -> Bool {
        let thisSet = Set(self.compactMap({ $0 as? String }))
        let thatSet = Set(array)
        if array.isEmpty {
            return true
        }
        for s in thatSet {
            if thisSet.contains(s) {
                return true
            }
        }
        return false
    }
}
