//
//  File.swift
//  
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

let contextBuilderLock = ContextMutex()
var executingWebThread: WebRequestContext? = nil
var withinPickerBuilder = false
var pickerBuilderType: PickerType? = nil

public extension WebRequestContext {
    func view(_ body: WebComposerClosure) {
        contextBuilderLock.mutex {
            executingWebThread = self
            body()
            executingWebThread = nil
        }
    }
}

public func View(context: WebRequestContext, _ body: WebComposerClosure) {
    context.view {
        body()
    }
}
