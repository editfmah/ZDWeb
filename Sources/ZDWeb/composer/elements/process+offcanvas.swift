//
//  File.swift
//  
//
//  Created by Adrian Herridge on 31/01/2023.
//

import Foundation

public extension WebRequestContext {
    @discardableResult
    func offCanvas(url: String, buttonTitle: String? = nil, style: Style, canvasTitle: String, size: BootstrapSize, id: String? = nil) -> String {
        let thisId = id ?? "offcanvas\(UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased())"
        var sz = "w-50"
        switch size {
        case .large:
            sz = "w-50"
        case .default:
            sz = "w-33"
        case .small:
            sz = "w-25"
        case .xlarge:
            sz = "w-75"
        case .xsmall:
            sz = "w-20"
        case .xxsmall:
            sz = "w-15"
        }
        self.div("offcanvas offcanvas-end \(sz)") {
            self.id(thisId)
            self.div("offcanvas-header") {
                self.h2(canvasTitle) {
                    self.class("offcanvas-title")
                }
                self.button(type: "button", class: "btn-close text-reset") {
                    self.property(property: "data-bs-dismiss", value: "offcanvas")
                }
            }
            self.div("offcanvas-body") {
                self.reloadable(id: "off-canvas-reloadable\(thisId)", url: url)
            }
        }
        if let buttonTitle = buttonTitle {
            self.button(type: "button", class: "btn btn-\(style.rawValue)") {
                self.property(property: "data-bs-toggle", value: "offcanvas")
                self.property(property: "data-bs-target", value: "#\(thisId)")
                self.text(buttonTitle)
            }
        }
        return thisId
    }
    
    enum Location: String {
        case end
        case start
    }
    
    func offcanvas(
              size: BootstrapSize,
          location: Location,
             style: WebComposerClosure? = nil,
            button: ((_ button: OffCanvasButtonBuilder) -> Void),
            header: ((_ header: OffCanvasHeaderBuilder) -> Void),
              body: ((_ containerId: String) -> Void)) {
        
                  let thisId = "offcanvas\(UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased())"
                  
                  var sz = "w-50"
                  switch size {
                  case .large:
                      sz = "w-50"
                  case .default:
                      sz = "w-33"
                  case .small:
                      sz = "w-25"
                  case .xlarge:
                      sz = "w-75"
                  case .xsmall:
                      sz = "w-20"
                  case .xxsmall:
                      sz = "w-10"
                  }
                  
                  self.div("offcanvas offcanvas-\(location.rawValue) \(sz)") {
                      self.id(thisId)
                      if let style = style {
                          style()
                      }
                      self.div("offcanvas-header") {
                          header(OffCanvasHeaderBuilder(c: self))
                      }
                      self.div("offcanvas-body") {
                          //self.id("body\(thisId)")
                          body("\(thisId)")
                      }
                  }
                  self.button(type: "button", class: "btn") {
                      self.property(property: "data-bs-toggle", value: "offcanvas")
                      self.property(property: "data-bs-target", value: "#\(thisId)")
                      button(OffCanvasButtonBuilder(c: self))
                  }
                  
    }
}

public class OffCanvasButtonBuilder {
    
    private var c: WebRequestContext
    
    public init(c: WebRequestContext) {
        self.c = c
    }
    
    public func setStyle(_ style: Style) {
        c.class("btn btn-\(style.rawValue)")
    }
    
    public func setButtonTitle(_ title: String) {
        c.text(title)
    }
    
    public func setBody(_ closure: ((_ c: WebRequestContext) -> Void)) {
        closure(self.c)
    }
    
}
                            
public class OffCanvasHeaderBuilder {
    
    private var c: WebRequestContext
    
    public init(c: WebRequestContext) {
        self.c = c
    }
    
    public func setTitleContent(_ closure: WebComposerContextClosure) {
        closure(self.c)
    }
    
    public func setTitle(_ title: String) {
        c.h2(title) {
            self.c.class("offcanvas-title")
        }
    }
    
    public func showCloseButton(show: Bool) {
        if show {
            self.c.button(type: "button", class: "btn-close text-reset") {
                self.c.property(property: "data-bs-dismiss", value: "offcanvas")
            }
        }
    }
    
}
