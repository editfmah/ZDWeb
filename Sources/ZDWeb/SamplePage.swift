//
//  SamplePage.swift
//  WebServer
//
//  Created by Adrian Herridge on 29/08/2021.
//

import Foundation

class SamplePage: WebHTMLEndpoint {

    static func register() {
        WebServer.registrations.append(SamplePage())
    }
    
    var grants: [WebNavigationActivity : [String]] = [
        .Content : [],
        .Modify : [],
        .Save : [],
        .Delete : [],
        .New : [],
        .View : [],
        .Raw : []
    ]

    var method: String? = nil
    
    var accessible: [AuthenticationStatus] = [.unauthenticated]
    
    var initialEndpoint: Bool = true
    
    var menuEntry: (primary: String, secondary: String?)? = ("Home",nil)
    
    func content(_ c: WebRequestContext) -> WebResponseObject? {
        c.html {
            c.class("testClass")
            c.id(UUID().uuidString.lowercased())
            c.body {
                c.h1("Sample Page \(Int.random(in: 0...1000000)) \(Date())") {
                    c.id(UUID().uuidString.lowercased())
                }
                c.h2("Sample Page \(Int.random(in: 0...1000000)) \(Date())") {
                    c.id(UUID().uuidString.lowercased())
                }
                c.h3("Sample Page \(Int.random(in: 0...1000000)) \(Date())") {
                    c.id(UUID().uuidString.lowercased())
                }
                c.h4("Sample Page \(Int.random(in: 0...1000000)) \(Date())") {
                    c.id(UUID().uuidString.lowercased())
                }
                c.h4("non-closure example")
                c.h1("Styled out") {
                    c.style([.height(value: 200),.width(value: 500)])
                }
            }
        }
    }
    
    func view(_ c: WebRequestContext) -> WebResponseObject? {
        return nil
    }
    
    func modify(_ c: WebRequestContext) -> WebResponseObject? {
        return nil
    }
    
    func new(_ c: WebRequestContext) -> WebResponseObject? {
        return nil
    }
    
    func save(_ c: WebRequestContext, data: WebRequestData) -> WebResponseObject? {
        return nil
    }
    
    func delete(_ c: WebRequestContext) -> WebResponseObject? {
        return nil
    }
    
    func raw(_ c: WebRequestContext) -> WebResponseObject? {
        return nil
    }
    
    func fragment(_ c: WebRequestContext, activity: WebNavigationActivity,  fragment: String) -> WebResponseObject? {
        return nil
    }
    
    var title: String = "Sample Page"
    var module: String?
    var controller: String?
    var requiresAuth: Bool = false
    
}
