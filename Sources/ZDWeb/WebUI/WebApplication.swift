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
    
    func generateHead() -> String {
        
        var headHTML = "<head>\n"
        headHTML += "<meta charset=\"\(WebApplication.charset)\">\n"
        headHTML += "<meta name=\"viewport\" content=\"\(WebApplication.viewport)\">\n"
        
        // Meta tags
        for (name, content) in WebApplication.metaTags {
            headHTML += "<meta name=\"\(name)\" content=\"\(content)\">\n"
        }
        for (name, content) in endpoint?.meta ?? [:] {
            headHTML += "<meta name=\"\(name)\" content=\"\(content)\">\n"
        }
        
        // Title
        headHTML += "<title>\(endpoint?.title ?? WebApplication.title)</title>\n"
        
        // Favicon
        headHTML += "<link rel=\"icon\" href=\"\(WebApplication.favicon)\" type=\"image/x-icon\">\n"
        
        // Stylesheets
        for stylesheet in WebApplication.stylesheets {
            headHTML += "<link rel=\"stylesheet\" href=\"\(stylesheet)\" type=\"text/css\">\n"
        }
        for stylesheet in endpoint?.styles ?? [] {
            headHTML += "<link rel=\"stylesheet\" href=\"\(stylesheet)\" type=\"text/css\">\n"
        }
        
        // Scripts
        for script in WebApplication.scripts {
            headHTML += "<script src=\"\(script)\"></script>\n"
        }
        for script in endpoint?.scripts ?? [] {
            headHTML += "<script src=\"\(script)\"></script>\n"
        }
        
        headHTML += "</head>\n"
        return headHTML
    }

    
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
    @discardableResult
    func WebApplicationView(_ body: WebComposerClosure) -> Self {
        // sets up the execution pipeline for the request
        
        // construct the html / head / body
        self.text("<!DOCTYPE html>\n")
        self.html(language: "EN") {
            self.output(generateHead())
            self.body {
                let _ = getExecutionPipeline()
                body()
                finishExecutionPipeline()
            }
        }
        
        compileBuilderScripts()
        return self
        
    }
    @discardableResult
    func WebApplicationPartialView(_ body: WebComposerClosure) -> Self {
        // sets up the execution pipeline for the request
        let _ = getExecutionPipeline()
        body()
        finishExecutionPipeline()
        compileBuilderScripts()
        return self
        
    }
}

public func WebApplicationView(context: WebRequestContext, _ body: WebComposerClosure) {
    context.WebApplicationView {
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

import Foundation

public class WebApplication {
    
    // Static properties for meta tags
    public static var title: String = "ZDWeb - Applicaiton"
    public static var charset: String = "utf-8"
    public static var viewport: String = "width=device-width, initial-scale=1"
    public static var metaTags: [String: String] = [
        "viewport": "width=device-width, initial-scale=1",
        "robots": "noindex"
    ]
    
    // Static properties for scripts and stylesheets
    public static var scripts: [String] = [
        "https://code.jquery.com/jquery-3.7.1.slim.min.js",
        "https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js",
        "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js",
        "https://cdn.jsdelivr.net/npm/spectrum-colorpicker2/dist/spectrum.min.js"
    ]
    
    public static var stylesheets: [String] = [
        "https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css",
        "https://cdn.jsdelivr.net/npm/spectrum-colorpicker2/dist/spectrum.min.css"
    ]
    
    // Static property for favicon
    public static var favicon: String = ""
    
}
