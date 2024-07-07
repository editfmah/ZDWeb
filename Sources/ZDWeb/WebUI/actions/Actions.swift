//
//  Actions.swift
//
//
//  Created by Adrian Herridge on 21/05/2024.
//

import Foundation

public enum WebAction {
    case script(String)
    case load(ref: String? = nil, url: String)
    case navigate(String)
    case post(url: String? = nil, values: [WebVariable]? = nil, onSuccessful: [WebAction]? = nil, onFailed: [WebAction]? = nil, onTimeout: [WebAction]? = nil, resultInto: WebVariable? = nil)
    case set(value: WebVariable, to: Any?)
    case addClass(String)
    case removeClass(String)
    case hidden(ref: String? = nil,_ value: Bool)
    case `if`(WebVariable, Operator, [WebAction], [WebAction]?)
    case toggle(WebVariable)
    case foregroundColor(ref: String? = nil,_ color: WebColor)
    case backgroundColor(ref: String? = nil,_ color: WebColor)
    case underlineColor(ref: String? = nil,_ color: WebColor)
    case underline(ref: String? = nil,_ value: Bool)
    case bold(ref: String? = nil,_ value: Bool)
    case italic(ref: String? = nil,_ value: Bool)
    case strikethrough(ref: String? = nil,_ value: Bool)
    case fontSize(ref: String? = nil,_ size: Int)
    case fontFamily(ref: String? = nil,_ name: String)
    case fontWeight(ref: String? = nil,_ weight: String)
    case opacity(ref: String? = nil,_ value: Double)
    case setStyle(ref: String? = nil,_ style: WebStyle)
    case random([WebAction])
    case showModal(ref: String)
}

public func CompileActions(_ actions: [WebAction], builderId: String) -> String {
    
        var script = ""
        
        for action in actions {
            switch action {
            case .navigate(let url):
                    script += "window.location.href = '\(url)';\n"
            case .load(ref: let ref, url: let url):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').src = '\(url)';\n"
                } else {
                    script += "\(builderId).src('\(url)');\n"
                }
            case .script(let scrpt):
                script += scrpt + "\n"
            case .post(url: let url,values: let values, onSuccessful: let onSuccessful, onFailed: let onFailed, onTimeout: let onTimeout, resultInto: let resultInto):
                
                // post data back to url or this url if nil, the array of values contains a property `name` which is the key for the json structure for data posting.
                
                script += "var postData = {};\n"
                for value in values ?? [] {
                   if let name = value.formName {
                       script += "postData['\(name)'] = \(value.builderId);\n";
                   }
                }
                
                // now use XMLHttpRequest() to send a JSON string encoding of the postData object to the server
                
                script += "var xhr = new XMLHttpRequest();\n"
                script += "xhr.open('POST', '\(url ?? "")', true);\n"
                script += "xhr.setRequestHeader('Content-Type', 'application/json');\n"
                script += "xhr.onreadystatechange = function() {\n"
                
                // check for a status code of 200, 201 or 202
                script += "     if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 201 || xhr.status == 202)) {\n"
                
                // copy the result if there is a target variable
                if let resultInto = resultInto {
                    script += "          \(resultInto.builderId) = xhr.responseText;\n"
                }
                
                if let onSuccessful = onSuccessful {
                    for action in onSuccessful {
                        script += CompileActions([action], builderId: builderId)
                    }
                }
                script += "     } else {\n"
                if let onFailed = onFailed {
                    for action in onFailed {
                        script += CompileActions([action], builderId: builderId)
                    }
                }
                script += "     }\n"
                script += "}\n"
                
                // set the request body to the JSON string encoding of the postData object
                script += "xhr.send(JSON.stringify(postData))\n"
                
            case .set(value: let value, to: let to):
                // cast to value into different common types and then update the value in the script from the builderId in value
                if let stringValue = to as? String {
                    script += "\(value.builderId) = '\(stringValue)';\n"
                } else if let intValue = to as? Int {
                    script += "\(value.builderId) = \(intValue);\n"
                } else if let doubleValue = to as? Double {
                    script += "\(value.builderId) = \(doubleValue);\n"
                } else if let boolValue = to as? Bool {
                    script += "\(value.builderId) = \(boolValue ? "true" : "false");\n"
                } else {
                    script += "\(value.builderId) = '\(to)';\n"
                }
            case .addClass(let className):
                script += "\(builderId).classList.add('\(className)');\n"
            case .removeClass(let className):
                script += "\(builderId).classList.remove('\(className)');\n"
            case .hidden(ref: let ref, let value):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.display = \(value ? "'none'" : "'block'");\n"
                } else {
                    script += "\(builderId).style.display = \(value ? "'none'" : "'block'");\n"
                }
            case .if(let variable, let condition, let ifActions, let elseActions):
                var ifScript = ""
                for action in ifActions {
                    ifScript += CompileActions([action], builderId: builderId)
                }
                if let elseActions = elseActions {
                    var elseScript = ""
                    for action in elseActions {
                        elseScript += CompileActions([action], builderId: builderId)
                    }
                    script += "if (\(variable.builderId) \(condition.javascriptCondition) {\n\(ifScript)\n} else {\n\(elseScript)\n}\n"
                } else {
                    script += "if (\(variable.builderId) \(condition.javascriptCondition) {\n\(ifScript)\n}\n"
                }
            case .toggle(let value):
                script += "\(value.builderId) = !\(value.builderId);\n"
            case .foregroundColor(ref: let ref, let color):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.color = '\(color.rgba)';\n"
                } else {
                    script += "\(builderId).style.color = '\(color.rgba)';\n"
                }
            case .backgroundColor(ref: let ref, let color):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.backgroundColor = '\(color.rgba)';\n"
                } else {
                    script += "\(builderId).style.backgroundColor = '\(color.rgba)';\n"
                }
            case .underlineColor(ref: let ref, let color):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.textDecorationColor = '\(color.rgba)';\n"
                } else {
                    script += "\(builderId).style.textDecorationColor = '\(color.rgba)';\n"
                }
            case .underline(ref: let ref, let value):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.textDecoration = \(value ? "'underline'" : "'none'");\n"
                } else {
                    script += "\(builderId).style.textDecoration = \(value ? "'underline'" : "'none'");\n"
                }
            case .bold(ref: let ref, let value):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.fontWeight = \(value ? "'bold'" : "'normal'");\n"
                } else {
                    script += "\(builderId).style.fontWeight = \(value ? "'bold'" : "'normal'");\n"
                }
            case .italic(ref: let ref, let value):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.fontStyle = \(value ? "'italic'" : "'normal'");\n"
                } else {
                    script += "\(builderId).style.fontStyle = \(value ? "'italic'" : "'normal'");\n"
                }
            case .strikethrough(ref: let ref, let value):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.textDecoration = \(value ? "'line-through'" : "'none'");\n"
                } else {
                    script += "\(builderId).style.textDecoration = \(value ? "'line-through'" : "'none'");\n"
                }
            case .fontSize(ref: let ref, let size):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.fontSize = '\(size)px';\n"
                } else {
                    script += "\(builderId).style.fontSize = '\(size)px';\n"
                }
            case .fontFamily(ref: let ref, let name):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.fontFamily = '\(name)';\n"
                } else {
                    script += "\(builderId).style.fontFamily = '\(name)';\n"
                }
            case .fontWeight(ref: let ref, let weight):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.fontWeight = '\(weight)';\n"
                } else {
                    script += "\(builderId).style.fontWeight = '\(weight)';\n"
                }
            case .opacity(ref: let ref, let value):
                if let ref = ref {
                    script += "document.getElementById('\(ref)').style.opacity = \(value);\n"
                } else {
                    script += "\(builderId).style.opacity = \(value);\n"
                }
            case .setStyle(ref: let ref, let style):
                
                if let ref = ref {
                    if let type = executionPipeline()?.types[ref] {
                        switch type {
                        case .text:
                            
                            // remove all the possible bootstrap styles for a text item
                            for color in WebStyle.all {
                                script += "document.getElementById('\(ref)').classList.remove('\(color.textStyleClass)');\n"
                            }
                            
                            // now add in the new style
                            script += "document.getElementById('\(ref)').classList.add('\(style.textStyleClass)');\n"
                            
                        case .button:
                                
                                // remove all the possible bootstrap styles for a button item
                                for color in WebStyle.all {
                                    script += "document.getElementById('\(ref)').classList.remove('\(color.buttonStyleClass)');\n"
                                }
                                
                                // now add in the new style
                                script += "document.getElementById('\(ref)').classList.add('\(style.buttonStyleClass)');\n"
                            
                        case .link:
                            
                            for color in WebStyle.all {
                                script += "document.getElementById('\(ref)').classList.remove('\(color.linkStyleClass)');\n"
                            }
                            
                            script += "document.getElementById('\(ref)').classList.add('\(style.linkStyleClass)');\n"
                            
                        case .image:
                            break;
                        case .unknown:
                            break;
                        }
                    }
                } else {
                
                    // we are looking up the object by class name (which is unique) and is the current builderId.
                    if let type = executionPipeline()?.types[builderId] {
                        switch type {
                        case .text:
                                // remove all the possible bootstrap styles for a text item
                                for color in WebStyle.all {
                                    script += "\(builderId).classList.remove('\(color.textStyleClass)');\n"
                                }
                                
                                // now add in the new style
                                script += "\(builderId).classList.add('\(style.textStyleClass)');\n"
                        case .button:
                                // remove all the possible bootstrap styles for a button item
                                for color in WebStyle.all {
                                    script += "\(builderId).classList.remove('\(color.buttonStyleClass)');\n"
                                }
                                
                                // now add in the new style
                                script += "\(builderId).classList.add('\(style.buttonStyleClass)');\n"
                        case .link:
                            for color in WebStyle.all {
                                script += "\(builderId).classList.remove('\(color.linkStyleClass)');\n"
                            }
                            
                            script += "\(builderId).classList.add('\(style.linkStyleClass)');\n"
                        case .image:
                            break;
                        case .unknown:
                            break;
                        }
                    }
                    
                }
                
            case .random(let actions):
                
                // create a random number in javascript between 0 and the count of actions, then execute that action.
                
                let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
                
                script += "var randomIndex\(id) = Math.floor(Math.random() * \(actions.count));\n"
                script += "var functions\(id) = [];\n"
                
                // now output the compiled action into the functions variable
                for action in actions {
                    script += "functions\(id).push(function() {\n"
                    script += CompileActions([action], builderId: builderId)
                    script += "});\n"
                }
                
                // now execute the random function
                script += "functions\(id)[randomIndex\(id)]();\n"
                
            case .showModal(ref: let ref):
                // this shows a bootstrap modal dialog, the ref is the id of the modal dialog to show.
                script += """
const myModal = new bootstrap.Modal('#\(ref)', {
  keyboard: false
})
myModal.show();
"""
            
            }
        }
        
        return script
    
}

extension GenericProperties {
    
    internal func compileActions(_ actions: [WebAction]) -> String {
        return CompileActions(actions, builderId: builderId)
    }
    
}
