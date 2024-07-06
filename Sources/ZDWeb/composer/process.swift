//
//  File.swift
//  
//
//  Created by Adrian Herridge on 29/08/2021.
//

import Foundation

public enum DataObjectType {
    case TextField
    case Checkbox
    case Combo
    case Secret
    case HiddenValue
}

public enum DataObjectValidation {
    case none
    case required
}

public struct DataObject {
    var type: DataObjectType
    var name: String
    var validator: DataObjectValidation
}

public class WebRequestContext {
    
    public var Fields: DataFormFields {
        get {
            return DataFormFields(context: self)
        }
    }
    
    // navigation/action properties
    public let service: WebServer
    public let request: HttpRequest
    public var navigation: WebNavigationPosition
    public var ephemiralData: [String:Any] = [:]
    public var stickyData: [String:Any] = [:]
    public var data: WebRequestData
    public var origin: String
    
    public var security = WebProcessSecurity()
 
    // page/response structure
    internal var blocks: [String] = []
    internal var bodySegments: [String] = []
    internal var builderScripts: [String] = []
    internal var elementProperties: [String:[String:Any?]] = [:]
    internal var elementTags: [String:[String]] = [:]
    
    public init(navigation: WebNavigationPosition, data: WebRequestData, service: WebServer, request: HttpRequest) {
        self.request = request
        self.navigation = navigation
        self.service = service
        self.data = data
        //TODO: implement this.
        self.origin = ""
    }
    
    public var body: String {
        get {
            /**
                                    PERFORM MAGIC
             
                                    Work backwards through the segments, and try to pair blocks with text content and truncate them
                For example:
                                    <p>
                                        Hi, this is a test
                                    </p>
             
                Would become:
             
                                 <p>Hi, this is a test</p>
             
             
             
             */
            
            let tagPairs: [(start: String, end: String)] = [("<a","</a>"),("<p","</p>"),("<h1","</h1>"),("<h2","</h2>"),("<h3","</h3>"),("<h4","</h4>"),("<h5","</h5>"),("<h6","</h6>"),("<h7","</h7>"),("<h8","</h8>"),("<li","</li>"),("<title","</title>"),("<th>","</th>"),("<b>","</b>"),("<td>","</td>"),("<textarea>","</textarea>")]
            
            let tagEnds = tagPairs.map({ $0.end })
           
            if bodySegments.count > 5 {
                for index in 2...bodySegments.count-1 {
                    let line = bodySegments[index].trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                    if tagEnds.contains(line.lowercased()) {
                        let start = bodySegments[index - 2].lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                        if let tags = tagPairs.first(where: { $0.end == line }) {
                            if start.starts(with: tags.start) && bodySegments[index - 1].contains(tags.end) == false {
                                // we have a winner to re-arrange
                                let line = bodySegments[index - 2] + bodySegments[index - 1].trimmingCharacters(in: .whitespaces) + tags.end
                                bodySegments[index - 2] = line
                                bodySegments[index - 1] = ""
                                bodySegments[index] = ""
                            }
                        }
                    }
                }
            }
            
            return bodySegments.filter({ !$0.isEmpty }).joined(separator: "\n")
        }
    }
    
    public var menuStructure : [MenuEntry] {
        get {
            var results: [MenuEntry] = []
            
            if security.authenticated {
                
                results = self.service.menus.filter({ $0.grants.isEmpty || $0.grants.filter({ security.grants.contains($0) }).isEmpty == false })
                results = results.filter({ $0.visibility.contains(.authenticated) })
                
                for result in results {
                    result.subordinates = result.subordinates.filter({  ($0.grants.isEmpty || $0.grants.filter({ security.grants.contains($0) }).isEmpty == false) && $0.visibility.contains(.authenticated) })
                    // set the header path to the first sobordinate object the user has permissions too
                    for subordinate in result.subordinates {
                        if subordinate.meth == self.navigation.method {
                            subordinate.selected = true
                        }
                    }
                }
                
                for result in results {
                    if result.cont == self.navigation.controller {
                        result.selected = true
                    }
                }
                
            } else {
                
                results = self.service.menus.filter({ $0.visibility.contains(.unauthenticated) })
                for result in results {
                    if (result.cont ?? "") == (self.navigation.controller ?? "") {
                        result.selected = true
                    }
                    result.subordinates = result.subordinates.filter({ $0.visibility.contains(.unauthenticated) })
                    for subordinate in result.subordinates {
                        if subordinate.meth == self.navigation.method {
                            subordinate.selected = true
                        }
                    }
                }
                
            }
            return results
        }
    }
    
    public func block(_ element: String, _ closure: WebComposerClosure) {
        blocks.append(UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: ""))
        let marker = output("<\(element)$elementProperties\(blocks.last!)$tags\(blocks.last!)>")
        elementProperties[blocks.last!] = [:]
        elementTags[blocks.last!] = []
        closure()
        var compiled = ""
        if elementProperties[blocks.last!]!.values.count > 0 {
            compiled = " "
            for kvp in elementProperties[blocks.last!]! {
                compiled += kvp.key
                if kvp.value != nil {
                    compiled += "="
                    if let value = kvp.value as? String {
                        compiled += "\"\(value)\" "
                    } else if let value = kvp.value as? Int {
                        compiled += "\(value) "
                    }
                } else {
                    compiled += " "
                }
            }
            if compiled.last == " " {
                compiled.removeLast()
            }
        }
        replace(marker, "$elementProperties\(blocks.last!)", to: compiled)
        let tags = elementTags[blocks.last!] ?? []
        replace(marker, "$tags\(blocks.last!)", to: tags.isEmpty ? "" : " \(tags.joined(separator: " "))")
        if !["link","input"].contains(element) {
            let _ = output("</\(element)>")
        }
        elementProperties.removeValue(forKey: blocks.last!)
        elementTags.removeValue(forKey: blocks.last!)
        blocks.removeLast()
    }
    
    public func declarative(_ element: String, identifier: String, id: String? = nil, type: String? = nil, for: String? = nil, name: String? = nil, attributes: [String:String]? = nil, _ closure: WebComposerClosure) {
        blocks.append(UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: ""))
        let marker = output("<\(element) class=\"\(identifier)\"\(id != nil ? " id=\"\(id!)\"" : "")\(type != nil ? " type=\"\(type!)\"" : "")\(`for` != nil ? " for=\"\(`for`!)\"" : "")\(name != nil ? " name=\"\(name!)\"" : "")\(attributes != nil ? " \(attributes!.map({ "\($0.key)=\"\($0.value)\"" }).joined(separator: " "))" : "")>")
        elementProperties[blocks.last!] = [:]
        elementTags[blocks.last!] = []
        closure()
        var compiled = ""
        if elementProperties[blocks.last!]!.values.count > 0 {
            compiled = " "
            for kvp in elementProperties[blocks.last!]! {
                compiled += kvp.key
                if kvp.value != nil {
                    compiled += "="
                    if let value = kvp.value as? String {
                        compiled += "\"\(value)\" "
                    } else if let value = kvp.value as? Int {
                        compiled += "\(value) "
                    }
                } else {
                    compiled += " "
                }
            }
            if compiled.last == " " {
                compiled.removeLast()
            }
        }
        if !["link","input"].contains(element) {
            let _ = output("</\(element)>")
        }
        elementProperties.removeValue(forKey: blocks.last!)
        elementTags.removeValue(forKey: blocks.last!)
        blocks.removeLast()
    }
    
    public func replace(_ index: Int, _ from: String, to: String) {
        var bs = bodySegments[index]
        bs = bs.replacingOccurrences(of: from, with: to)
        bodySegments[index] = bs
    }
    @discardableResult
    public func output(_ data: String) -> Int {
        var body = ""
        if !blocks.isEmpty {
            for _ in 0..<blocks.count - 1 {
                body += "   "
            }
        }
        body += data
        bodySegments.append(body)
        return (bodySegments.count - 1)
    }
    
    public func width(_ w: Int) {
        elementProperties[blocks.last!]!["width"] = w
    }
    
    public func `class`(_ cls: String) {
        elementProperties[blocks.last!]!["class"] = cls
    }
    
    public func id(_ id: String) {
        elementProperties[blocks.last!]!["id"] = id
    }
    
    public func role(_ role: String) {
        elementProperties[blocks.last!]!["role"] = role
    }
    
    public func name(_ name: String) {
        elementProperties[blocks.last!]!["name"] = name
    }
    
    public func type(_ type: String) {
        elementProperties[blocks.last!]!["type"] = type
    }
    
    public func value(_ value: String) {
        elementProperties[blocks.last!]!["value"] = value
    }
    
    public func style(_ style: StyleProperty) {
        elementProperties[blocks.last!]!["style"] = style.compiled
    }
    
    public func style(_ styles: [StyleProperty]) {
        var compiled = ""
        for s in styles {
            compiled += s.compiled
        }
        elementProperties[blocks.last!]!["style"] = compiled
    }
    
    public func property(property: String, value: String?) {
        self.elementProperties[blocks.last!]![property] = value
    }
    
    public func tag(property: String) {
        self.elementTags[blocks.last!]?.append(property)
    }
    
    public func redirect(_ path: String) -> HttpResponse {
        return HttpResponse.redirect(path, self.security.token)
    }
    
    public func repeatActionWithFeedback(banner: String?, field: String?, error: String?) {
        // takes the posted data, and sends it back to the originating form and displays the error states.
        
    }
    
}

public class WebProcessSecurity {
    public var userId: UUID?
    public var account: UUID?
    public var authenticated = false
    public var grants: [String] = [] // to be filtered down to only the grants for the account in the request
    public var token: String?
    public var username: String?
    public var mocking = false
}
