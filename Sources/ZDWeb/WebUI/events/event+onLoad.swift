//
//  File.swift
//
//
//  Created by Adrian Herridge on 02/08/2024.
//

import Foundation

extension GenericProperties {
    
    @discardableResult
    public func onAppear(_ action: WebAction) -> Self {
        return onAppear([action]);
    }
    
    @discardableResult
    public func onAppear(_ actions: [WebAction]) -> Self {
        
        executionPipeline()?.context?.builderScript("""
   var lastVisibility\(builderId) = false;
   
   function checkVisibility\(builderId)() {
       var rect = \(builderId).getBoundingClientRect();
       var isVisible = (
           rect.top >= 0 &&
           rect.left >= 0 &&
           rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
           rect.right <= (window.innerWidth || document.documentElement.clientWidth)
       );
   
       if (isVisible != lastVisibility\(builderId)) {
           if (isVisible) {
               \(builderId).onAppear();
           }
           lastVisibility\(builderId) = isVisible;
       }
   }
   
   var appearInterval\(builderId) = setInterval(checkVisibility\(builderId), 500);
   
   \(builderId).onAppear = function() {
       \(compileActions(actions))
   };
   """)
        return self
    }
    
    
    @discardableResult
    public func onInit(_ action: WebAction) -> Self {
        return onInit([action])
    }
    
    @discardableResult
    public func onInit(_ actions: [WebAction]) -> Self {
        
        executionPipeline()?.context?.builderScript("""
           document.addEventListener('DOMContentLoaded', function() {
               if (document.body.contains(\(builderId))) {
                   \(builderId).onInit();
               } else {
                   var observer = new MutationObserver(function(mutations, observer) {
                       if (document.body.contains(\(builderId))) {
                           \(builderId).onInit();
                           observer.disconnect();
                       }
                   });
                   observer.observe(document, { childList: true, subtree: true });
               }
           });
           
           \(builderId).onInit = function() {
               \(compileActions(actions))
           };
           """)
        
        return self
    }
}
