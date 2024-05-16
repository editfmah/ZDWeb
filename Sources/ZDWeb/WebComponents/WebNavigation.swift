//
//  File.swift
//  
//
//  Created by Adrian Herridge on 11/05/2020.
//

import Foundation

extension UUID {
    var string: String  {
        return self.uuidString.lowercased()
    }
}

public enum WebNavigationActivity : String, Codable {
    case View = "view"
    case Modify = "modify"
    case New = "new"
    case Save = "save"
    case Content = "content"
    case Delete = "delete"
    case Raw = "raw"
    static func from(string: String) -> WebNavigationActivity {
        return WebNavigationActivity.init(rawValue: string) ?? .Content
    }
}

public class WebNavigationPosition {
    
    public var controller: String?
    public var method: String?
    
    public var action: WebNavigationActivity?
    public var resource: UUID?
    public var sub: UUID?
    public var version: UUID?
    public var filter: [String:String]?
    public var fragment: String?
    public var returnUrl: String?
    public var interactive: Bool?
    
    fileprivate var decodedObject: ParameterDecodingObject? = nil
    
    public init() {}
    
    public init(_ endpoint: WebEndpoint) {
        self.controller = endpoint.controller
        self.method = endpoint.method
    }
    
    public init(_ current: WebRequestContext) {
        self.controller = current.navigation.controller
        self.method = current.navigation.method
        self.resource = current.navigation.resource
        self.sub = current.navigation.sub
        self.filter = current.navigation.filter
        self.fragment = current.navigation.fragment
        self.action = current.navigation.action
        self.returnUrl = current.navigation.returnUrl
    }
    
    /**
        Initialisation of this object is to inspect the request object for all navigation parameters, authentication and payloads
     
            Navigation items will be contained within the URL, Query Parameters, Headers & Body (JSON object & Form Post Data).
     
     */
    public init(_ request: HttpRequest) {
        
        let path = request.path
        
        // first split off the controller & method items
        // Array<String> [http://127.0.0.1:4242]/[controller]/[method]
        
        let components = path.components(separatedBy: "/")
        if components.count > 1 {
            controller = components[1]
        }
        if components.count > 2 {
            method = components[2]
        }
        
        /**
         
            *Now we want to go looking for 'action','resource','account','sub','version','filter' in all the appropriate communication mediums*
         
            order of precedence is:

                *Query Parameters*
                *Request Headers*
                *Form post data*
                *JSON request body*

         */
        
        // action
        if let action = request.queryParams.first(where: {$0.0.lowercased() == "action"})?.1{
            self.action = WebNavigationActivity(rawValue: action)
        } else if let action = request.headers["action"], let actionType = WebNavigationActivity(rawValue: action) {
            self.action = actionType
        } else if let action = request.parseUrlencodedForm()["action"], let actionType = WebNavigationActivity(rawValue: action) {
            self.action = actionType
        } else if let action = tryDecodeBody(request: request)?.action, let actionType = WebNavigationActivity(rawValue: action) {
            self.action = actionType
        }
        
        // resource
        if let resource = request.queryParams.first(where: {$0.0.lowercased() == "resource"})?.1, let uuid = UUID(uuidString: resource) {
            self.resource = uuid
        } else if let resource = request.headers["resource"], let uuid = UUID(uuidString: resource) {
            self.resource = uuid
        } else if let resource = request.parseUrlencodedForm()["resource"], let uuid = UUID(uuidString: resource) {
            self.resource = uuid
        } else if let uuid = tryDecodeBody(request: request)?.resource {
            self.resource = uuid
        }
        
        // sub-resource
        if let resource = request.queryParams.first(where: {$0.0.lowercased() == "sub"})?.1, let uuid = UUID(uuidString: resource) {
            self.sub = uuid
        } else if let resource = request.headers["sub"], let uuid = UUID(uuidString: resource) {
            self.sub = uuid
        } else if let resource = request.parseUrlencodedForm()["sub"], let uuid = UUID(uuidString: resource) {
            self.sub = uuid
        } else if let uuid = tryDecodeBody(request: request)?.sub {
            self.sub = uuid
        }
        
        // version
        if let version = request.queryParams.first(where: {$0.0.lowercased() == "version"})?.1, let uuid = UUID(uuidString: version) {
            self.version = uuid
        } else if let version = request.headers["version"], let uuid = UUID(uuidString: version) {
            self.version = uuid
        } else if let version = request.parseUrlencodedForm()["version"], let uuid = UUID(uuidString: version) {
            self.version = uuid
        } else if let uuid = tryDecodeBody(request: request)?.version {
            self.version = uuid
        }
        
        // filter
        var filterString = ""
        if let filter = request.queryParams.first(where: {$0.0.lowercased() == "filter"})?.1, filter.count > 0 {
            filterString = filter
        } else if let filter = request.headers["filter"] {
            filterString = filter
        } else if let filter = request.parseUrlencodedForm()["filter"] {
            filterString = filter
        } else if let filter = tryDecodeBody(request: request)?.filter {
            filterString = filter
        }
        filter = nil
        if let newString = filterString.removingPercentEncoding {
            filterString = newString
        }
        if filterString.isEmpty == false {
            filter = [:]
            for i in filterString.components(separatedBy: ";") {
                let kv = i.components(separatedBy: "|")
                if kv.count == 2 {
                    filter?[kv.first!] = kv.last!
                }
            }
        }
        
        // fragment
        if let fragment = request.queryParams.first(where: {$0.0.lowercased() == "fragment"})?.1, fragment.count > 0 {
            self.fragment = fragment.removingPercentEncoding ?? fragment
        } else if let fragment = request.headers["fragment"] {
            self.fragment = fragment
        } else if let fragment = request.parseUrlencodedForm()["fragment"] {
            self.fragment = fragment
        } else if let fragment = tryDecodeBody(request: request)?.fragment {
            self.fragment = fragment
        }
        
        // return url
        if let returnUrl = request.queryParams.first(where: {$0.0.lowercased() == "returnUrl"})?.1, returnUrl.count > 0 {
            self.returnUrl = returnUrl.removingPercentEncoding ?? returnUrl
        } else if let returnUrl = request.headers["returnUrl"] {
            self.returnUrl = returnUrl
        } else if let returnUrl = request.parseUrlencodedForm()["returnUrl"] {
            self.returnUrl = returnUrl
        }
        
        // if the action type is missing then infer from the HTTP request type
        
        if action == nil {
            switch request.method {
            case "GET":
                action = .Content
            case "HEAD":
                action = .Content
            case "OPTIONS":
                action = .Content
            case "POST":
                action = .Save
            case "DELETE":
                action = .Delete
            case "PATCH":
                action = .Modify
            default:
                action = .Content
            }
        }
    }
    
    public var url: String {
        get {
            var path = "/"
            if let c = controller {
                path += c
            }
            if let m = method {
                path += "/"
                path += m
            }
            path += "?"
            if let r = resource {
                path += "resource=\(r.uuidString.lowercased())&"
            }
            if let r = sub {
                path += "sub=\(r.uuidString.lowercased())&"
            }
            if let v = version {
                path += "version=\(v.uuidString.lowercased())&"
            }
            if let a = action {
                path += "action=\(a.rawValue)&"
            }
            if let f = filter, f.count > 0 {
                path += "filter=\(f.map({ return "\($0.key)|\($0.value)" }).joined(separator: ";").urlFriendly)&"
            }
            if let f = fragment, f.count > 0 {
                path += "fragment=\(f.urlFriendly)&"
            }
            if let f = returnUrl, f.count > 0 {
                path += "returnUrl=\(f.urlFriendly)&"
            }
            return path
        }
    }
    
    fileprivate func thisBut(_ action: WebNavigationActivity? = nil, resource: UUID? = nil, account: UUID? = nil) -> String {
        
        var path = "/"
        if let c = controller {
            path += c
        }
        if let m = method {
            path += "/"
            path += m
        }
        path += "?"
        if let action = action {
            path += "action=\(action.rawValue)&"
        }
        if let r = resource {
            path += "resource=\(r.uuidString.lowercased())&"
        }
        if let f = filter, f.count > 0 {
            path += "filter=\(f.map({ return "\($0.key)|\($0.value)" }).joined(separator: ";").urlFriendly)&"
        }
        if let f = fragment, f.count > 0 {
            path += "fragment=\(f.urlFriendly)&"
        }
        if let f = returnUrl, f.count > 0 {
            path += "returnUrl=\(f.urlFriendly)&"
        }
        return path
        
    }
    
    public func target(_ action: WebNavigationActivity) -> String {
        return thisBut(action, resource: self.resource)
    }
    
    public func target(_ action: WebNavigationActivity, resource: UUID?) -> String {
        return thisBut(action, resource: resource)
    }
    
    public func target(_ action: WebNavigationActivity, resource: UUID?, account: UUID?) -> String {
        return thisBut(action, resource: resource)
    }
    
    public var path: String {
        get {
            var path = "/"
            if let c = controller {
                path += c
            }
            if let m = method {
                path += "/"
                path += m
            }
            return path
        }
    }
    
    fileprivate func tryDecodeBody(request: HttpRequest) -> ParameterDecodingObject? {
        
        if let object = self.decodedObject {
            return object
        }
        if let newDecodedObject = try? JSONDecoder().decode(ParameterDecodingObject.self, from: Data(request.body)) {
            self.decodedObject = newDecodedObject
        }
        return self.decodedObject
        
    }
    
    // fluent interface for builders
    @discardableResult
    public func setResource(_ uuid: UUID) -> WebNavigationPosition {
        self.resource = uuid
        return self
    }
    @discardableResult
    public func setsub(_ uuid: UUID) -> WebNavigationPosition {
        self.sub = uuid
        return self
    }
    @discardableResult
    public func setFilter(_ filter: [String:String]) -> WebNavigationPosition {
        self.filter = filter
        return self
    }
    @discardableResult
    public func setAction(_ action: WebNavigationActivity) -> WebNavigationPosition {
        self.action = action
        return self
    }
    @discardableResult
    public func setFragment(_ fragment: String) -> WebNavigationPosition {
        self.fragment = fragment
        return self
    }
    @discardableResult
    public func setReturnUrl(_ url: String) -> WebNavigationPosition {
        self.returnUrl = url
        return self
    }
    @discardableResult
    public func setController(_ controller: String) -> WebNavigationPosition {
        self.controller = controller
        return self
    }
    @discardableResult
    public func setMethod(_ method: String) -> WebNavigationPosition {
        self.method = method
        return self
    }

}

extension String {
    var urlFriendly: String {
        if let s = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return s
        }
        return self
    }
}
