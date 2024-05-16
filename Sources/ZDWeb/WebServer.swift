import Foundation

public class WebServer {
    
    // global objects for all instances to make use of
    static public var registrations: [WebEndpoint] = []
    static public var servers: [WebServer] = []
    static public var bans: [String] = []
    
    // instance vars
    private var port: UInt16
    private var svr: HttpServer
    
    fileprivate var menuStructure: [MenuEntry] = []
    
    internal var menus: [MenuEntry] {
        get {
            return menuStructure.map({ MenuEntry().copyFrom($0) })
        }
    }
    
    // action blocks

    public init(port: Int, bindAddressv4: String? = nil, onAccept: @escaping OnWebRequest) {
        
        self.port = UInt16(port)
        self.svr = HttpServer()

        for r in WebServer.registrations {
            
            if let r = r as? WebHTMLEndpoint {
                var path = "/"
                if let module = r.controller {
                    path += module
                    if let controller = r.method {
                        path += "/"
                        path += controller
                    }
                } else if let controller = r.method {
                    path += controller
                }
                
                let requestHandler: ((HttpRequest) -> HttpResponse) = { request in
                    
                    let c = WebRequestContext(navigation: WebNavigationPosition(request), data: WebRequestData(request), service: self, request: request)
                    onAccept(c)
                    
                    // check authentication status
                    if !r.accessible.contains(.unauthenticated) {
                        // check for valid authentication
                        if !(c.security.authenticated) {
                            return .redirect("/", nil)
                        }
                    }
                    
                    var responseObject: WebResponseObject? = nil
                    
                    if let fragment = c.navigation.fragment {
                        responseObject = r.fragment(c, activity: c.navigation.action ?? .Content, fragment: fragment)
                    } else {
                        // non-fragment, so pay attention to the action
                        switch c.navigation.action {
                        case .Content:
                            if (c.security.grants).containsAnyOf((r.grants[.Content] ?? [])) {
                                // now check if it is a request for a fragment
                                responseObject = r.content(c)
                            }
                        case .View:
                            if (c.security.grants).containsAnyOf((r.grants[.View] ?? [])) {
                                responseObject = r.view(c)
                            } else {
                                responseObject = c.redirect(c.navigation.target(.Content))
                            }
                        case .Save:
                            if (c.security.grants).containsAnyOf((r.grants[.Save] ?? [])) {
                                responseObject = r.save(c, data: c.data)
                            } else {
                                responseObject = c.redirect(c.navigation.target(.Content))
                            }
                        case .Modify:
                            if (c.security.grants).containsAnyOf((r.grants[.Modify] ?? [])) {
                                responseObject = r.modify(c)
                            } else {
                                responseObject = c.redirect(c.navigation.target(.Content))
                            }
                        case .New:
                            if (c.security.grants).containsAnyOf((r.grants[.New] ?? [])) {
                                responseObject = r.new(c)
                            } else {
                                responseObject = c.redirect(c.navigation.target(.Content))
                            }
                        case .Delete:
                            if (c.security.grants).containsAnyOf((r.grants[.Delete] ?? [])) {
                                responseObject = r.delete(c)
                            } else {
                                responseObject = c.redirect(c.navigation.target(.Content))
                            }
                        case .Raw:
                            if (c.security.grants).containsAnyOf((r.grants[.Raw] ?? [])) {
                                responseObject = r.raw(c)
                            }
                        default:
                            break
                        }
                    }
                    
                    if let response = responseObject {
                        return response.httpResponse()
                    } else {
                        return .internalServerError
                    }

                }
                
                svr.get[path] = requestHandler
                svr.post[path] = requestHandler
                svr.delete[path] = requestHandler
                svr.patch[path] = requestHandler
                svr.options[path] = requestHandler
                svr.head[path] = requestHandler
                
                // now register the menu endpoint
                if let menuObject = r as? MenuIndexable {
                    if let entry = menuObject.menuEntry {
                        if let header = menuStructure.first(where: { $0.primary == entry.primary }), let secondary = entry.secondary {
                            
                            // we have a header record already, so lets create a subordinate
                            let item = MenuEntry()
                            item.primary = entry.primary
                            item.secondary = entry.secondary
                            item.title = secondary
                            item.grants = r.grants[.Content] ?? []
                            item.visibility = r.accessible
                            item.cont = r.controller
                            item.meth = r.method
                            item.glyph = menuObject.glyph
                            
                            for g in item.grants {
                                if !header.grants.contains(g) {
                                    header.grants.append(g)
                                }
                            }
                            header.subordinates.append(item)
                            
                        } else {
                            
                            let header = MenuEntry()
                            header.title = entry.primary
                            header.glyph = menuObject.glyph
                            header.primary = entry.primary
                            header.visibility = r.accessible
                            header.grants = r.grants[.Content] ?? []
                            header.cont = r.controller
                            header.meth = r.method
                            
                            if let secondary = entry.secondary {
                                let item = MenuEntry()
                                item.secondary = secondary
                                item.glyph = menuObject.glyph
                                item.primary = entry.primary
                                item.title = secondary
                                item.grants = r.grants[.Content] ?? []
                                item.visibility = r.accessible
                                item.cont = r.controller
                                item.meth = r.method
                                header.subordinates.append(item)
                            }
                            menuStructure.append(header)
                        }
                    }
                }
                
            }  else if let r = r as? WebAPIEndpoint {
                
                var path = "/"
                if let module = r.controller {
                    path += module
                    if let controller = r.method {
                        path += "/"
                        path += controller
                    }
                } else if let controller = r.method {
                    path += controller
                }
                
                let requestHandler: ((HttpRequest) -> HttpResponse) = { request in
                    let c = WebRequestContext(navigation: WebNavigationPosition(request), data: WebRequestData(request), service: self, request: request)
                    onAccept(c)
                 
                    // check authentication status
                    if !r.accessible.contains(.unauthenticated) {
                        // check for valid authentication
                        if !(c.security.authenticated) {
                            return .forbidden(.none)
                        }
                    }
                    
                    if let response = r.call(c, data: c.data)?.httpResponse() {
                        return response
                    } else {
                        return .internalServerError
                    }
                }
                
                svr.get[path] = requestHandler
                svr.post[path] = requestHandler
                svr.delete[path] = requestHandler
                svr.patch[path] = requestHandler
                svr.options[path] = requestHandler
                svr.head[path] = requestHandler
  
            }
            
        }
        #if os(OSX)
        self.svr.listenAddressIPv4 = bindAddressv4 ?? "127.0.0.1"
        #endif
        try? self.svr.start(self.port, forceIPv4: true, priority: .userInteractive)
        
        // finally add it into the pool
        WebServer.servers.append(self)
    }
    
}

public class MenuEntry {
    
    public var title: String = ""
    public var visibility: [AuthenticationStatus] = []
    public var grants: [String] = []
    public var subordinates: [MenuEntry] = []
    public var primary: String?
    public var secondary: String?
    public var selected: Bool = false
    public var cont: String?
    public var meth: String?
    public var header: Bool = false
    public var glyph: Glyph?
    
    public func copyFrom(_ menu: MenuEntry) -> MenuEntry {
        self.title = menu.title
        self.visibility = menu.visibility.map({ return $0 })
        self.grants = menu.grants.map({ return $0 })
        for s in menu.subordinates {
            self.subordinates.append(MenuEntry().copyFrom(s))
        }
        self.primary = menu.primary
        self.secondary = menu.secondary
        self.selected = menu.selected
        self.cont = menu.cont
        self.meth = menu.meth
        self.glyph = menu.glyph
        return self
    }
}

public typealias OnWebRequest = ( (WebRequestContext) -> Void )
