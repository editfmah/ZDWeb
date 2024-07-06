//
//  context+view.swift
//
//
//  Created by Adrian Herridge on 18/02/2024.
//

import Foundation

let executionPipelineLock = ContextMutex()

// pipelines are created for each request, and are used to manage the execution of the request
var executionPipelineObjects: [String : WebRequestExecutionPipeline] = [:]

public class WebRequestExecutionPipeline {
    var context: WebRequestContext? = nil
    var lastAccessed: Date = Date()
    var withinPickerBuilder = false
    var withinFormBuilder = false
    var pickerType: PickerType = .dropdown
    var types: [String:WebElementType] = [:]
    var metadata: [String:Any] = [:]
}

func executionPipeline() -> WebRequestExecutionPipeline? {
    let id = "Thread-\(Thread.current.description)"
    var pipeline: WebRequestExecutionPipeline? = nil
    executionPipelineLock.mutex {
        if let p = executionPipelineObjects[id] {
            pipeline = p
            p.lastAccessed = Date()
        }
    }
    return pipeline
}

public extension WebRequestContext {
    
    func getExecutionPipeline() -> WebRequestExecutionPipeline {
        let id = "Thread-\(Thread.current.description)"
        var pipeline: WebRequestExecutionPipeline! = nil
        executionPipelineLock.mutex {
            if let p = executionPipelineObjects[id] {
                pipeline = p
                p.lastAccessed = Date()
            } else {
                pipeline = WebRequestExecutionPipeline()
                pipeline.context = self
                pipeline.lastAccessed = Date()
                executionPipelineObjects[id] = pipeline
            }
        }
        return pipeline
    }

    func finishExecutionPipeline() {
        let id = "Thread-\(Thread.current.description)"
        executionPipelineLock.mutex {
            executionPipelineObjects.removeValue(forKey: id)
        }
    }
    
    // clean up old pipelines that have not been touched for 10 seconds
    func cleanExecutionPipelines() {
        let now = Date()
        executionPipelineLock.mutex {
            for (key, pipeline) in executionPipelineObjects {
                if now.timeIntervalSince(pipeline.lastAccessed) > 10 {
                    executionPipelineObjects.removeValue(forKey: key)
                }
            }
        }
    }
    
}

public extension WebRequestContext {
    func view(_ body: WebComposerClosure) {
        print("View thread: thread-\(Thread.current.description)")
        // sets up the execution pipeline for the request
        let _ = getExecutionPipeline()
        body()
        finishExecutionPipeline()
    }
}

public func View(context: WebRequestContext, _ body: WebComposerClosure) {
    context.view {
        body()
    }
}

public enum WebElementType {
    case text
    case button
    case link
    case image
    case unknown
}
