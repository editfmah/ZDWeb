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
    case set(variable: WebVariable? = nil, input: String? = nil, varName: String? = nil, to: Any?)
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
    case showModal(ref: String, contentURL: String? = nil)
    case hideModal(ref: String)
    case collapse(ref: String)
    case popover(title: String, content: String)
    case showOffCanvas(ref: String)
    case hideOffCanvas(ref: String)
    case carouselNext(ref: String)
    case carouselPrev(ref: String)
    case carouselTo(ref: String, index: Int)
    case accordionToggle(ref: String)
    case progressSet(ref: String, value: Int)
    case spinnerSet(ref: String, type: SpinnerType, size: SpinnerSize, color: WebColor, label: String)
    // this response receives the body of the response from the post request, followed by the code, fillowed by the headers
    /*
     so the structure looks like function(body, code, headers) { /* your code goes here and you can access body, code, headers */ }
     */
    case handleResponse(script: String)
    case src(ref: String? = nil, url: String)
    case scrollTo(ref: String? = nil, behavior: ScrollBehavior, alignment: ScrollAlignment = .start)
    case addToArray(variable: WArray, value: String)
    case removeFromArray(variable: WArray, value: String)
    case fadeIn(ref: String? = nil, duration: Double)
    case fadeOut(ref: String? = nil, duration: Double)
    case fadeToggle(ref: String? = nil, duration: Double)
    
}

public func CompileActions(_ actions: [WebAction], builderId: String) -> String {
    var script = ""
    
    for action in actions {
        switch action {
            
        case .fadeIn(let ref, let duration):
            if let ref = ref {
                script += """
                        var element = document.getElementById('\(ref)');
                        if (element) {
                            if (element.style.opacity === '' || parseFloat(element.style.opacity) < 1) {
                                element.style.opacity = 0;
                                element.style.display = 'block';
                                var last = +new Date();
                                var tick = function() {
                                    element.style.opacity = +element.style.opacity + (new Date() - last) / (\(duration) * 1000);
                                    last = +new Date();
                                    if (+element.style.opacity < 1) {
                                        (window.requestAnimationFrame && requestAnimationFrame(tick)) || setTimeout(tick, 16);
                                    }
                                };
                                tick();
                            }
                        }
                        """
            } else {
                script += """
                        if (\(builderId).style.opacity === '' || parseFloat(\(builderId).style.opacity) < 1) {
                            \(builderId).style.opacity = 0;
                            \(builderId).style.display = 'block';
                            var last = +new Date();
                            var tick = function() {
                                \(builderId).style.opacity = +\(builderId).style.opacity + (new Date() - last) / (\(duration) * 1000);
                                last = +new Date();
                                if (+\(builderId).style.opacity < 1) {
                                    (window.requestAnimationFrame && requestAnimationFrame(tick)) || setTimeout(tick, 16);
                                }
                            };
                            tick();
                        }
                        """
            }
            
        case .fadeOut(let ref, let duration):
            if let ref = ref {
                script += """
                        var element = document.getElementById('\(ref)');
                        if (element) {
                            element.style.opacity = 1;
                            var last = +new Date();
                            var tick = function() {
                                element.style.opacity = +element.style.opacity - (new Date() - last) / (\(duration) * 1000);
                                last = +new Date();
                                if (+element.style.opacity > 0) {
                                    (window.requestAnimationFrame && requestAnimationFrame(tick)) || setTimeout(tick, 16);
                                } else {
                                    element.style.display = 'none';
                                }
                            };
                            tick();
                        }
                        """
            } else {
                script += """
                        \(builderId).style.opacity = 1;
                        var last = +new Date();
                        var tick = function() {
                            \(builderId).style.opacity = +\(builderId).style.opacity - (new Date() - last) / (\(duration) * 1000);
                            last = +new Date();
                            if (+\(builderId).style.opacity > 0) {
                                (window.requestAnimationFrame && requestAnimationFrame(tick)) || setTimeout(tick, 16);
                            } else {
                                \(builderId).style.display = 'none';
                            }
                        };
                        tick();
                        """
            }
            
        case .fadeToggle(let ref, let duration):
            if let ref = ref {
                script += """
                        var element = document.getElementById('\(ref)');
                        if (element) {
                            if (element.style.display === 'none' || getComputedStyle(element).display === 'none') {
                                element.style.opacity = 0;
                                element.style.display = 'block';
                                var last = +new Date();
                                var tick = function() {
                                    element.style.opacity = +element.style.opacity + (new Date() - last) / (\(duration) * 1000);
                                    last = +new Date();
                                    if (+element.style.opacity < 1) {
                                        (window.requestAnimationFrame && requestAnimationFrame(tick)) || setTimeout(tick, 16);
                                    }
                                };
                                tick();
                            } else {
                                var last = +new Date();
                                var tick = function() {
                                    element.style.opacity = +element.style.opacity - (new Date() - last) / (\(duration) * 1000);
                                    last = +new Date();
                                    if (+element.style.opacity > 0) {
                                        (window.requestAnimationFrame && requestAnimationFrame(tick)) || setTimeout(tick, 16);
                                    } else {
                                        element.style.display = 'none';
                                    }
                                };
                                tick();
                            }
                        }
                        """
            } else {
                script += """
                        if (\(builderId).style.display === 'none' || getComputedStyle(\(builderId)).display === 'none') {
                            \(builderId).style.opacity = 0;
                            \(builderId).style.display = 'block';
                            var last = +new Date();
                            var tick = function() {
                                \(builderId).style.opacity = +\(builderId).style.opacity + (new Date() - last) / (\(duration) * 1000);
                                last = +new Date();
                                if (+\(builderId).style.opacity < 1) {
                                    (window.requestAnimationFrame && requestAnimationFrame(tick)) || setTimeout(tick, 16);
                                }
                            };
                            tick();
                        } else {
                            var last = +new Date();
                            var tick = function() {
                                \(builderId).style.opacity = +\(builderId).style.opacity - (new Date() - last) / (\(duration) * 1000);
                                last = +new Date();
                                if (+\(builderId).style.opacity > 0) {
                                    (window.requestAnimationFrame && requestAnimationFrame(tick)) || setTimeout(tick, 16);
                                } else {
                                    \(builderId).style.display = 'none';
                                }
                            };
                            tick();
                        }
                        """
            }
            
            
        case .addToArray(let variable, let value):
            script += """
                    if (\(variable.builderId).indexOf('\(value)') === -1) {
                        \(variable.builderId).push('\(value)');
                        document.getElementById('hiddenInput_\(variable.builderId)').value = JSON.stringify(\(variable.builderId));
                    }
                    """
            
        case .removeFromArray(let variable, let value):
            script += """
                    var index = \(variable.builderId).indexOf('\(value)');
                    if (index !== -1) {
                        \(variable.builderId).splice(index, 1);
                        document.getElementById('hiddenInput_\(variable.builderId)').value = JSON.stringify(\(variable.builderId));
                    }
                    """
            
        case .scrollTo(let ref, let behavior, let alignment):
            let refId = ref ?? builderId
            script += """
                    var element = document.getElementById('\(refId)');
                    element.scrollIntoView({ behavior: '\(behavior.rawValue)', block: '\(alignment.rawValue)', inline: '\(alignment.rawValue)' });
                    """
            
        case .showOffCanvas(let ref):
            script += """
            var offcanvasElement = document.getElementById('\(ref)');
            if (offcanvasElement) {
                var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                offcanvas.show();
            }
            """
            
        case .hideOffCanvas(let ref):
            script += """
            var offcanvasElement = document.getElementById('\(ref)');
            if (offcanvasElement) {
                var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                offcanvas.hide();
            }
            """
            
        case .carouselNext(let ref):
            script += """
            var carouselElement = document.getElementById('\(ref)');
            if (carouselElement) {
                var carousel = new bootstrap.Carousel(carouselElement);
                carousel.next();
            }
            """
            
        case .carouselPrev(let ref):
            script += """
            var carouselElement = document.getElementById('\(ref)');
            if (carouselElement) {
                var carousel = new bootstrap.Carousel(carouselElement);
                carousel.prev();
            }
            """
            
        case .carouselTo(let ref, let index):
            script += """
            var carouselElement = document.getElementById('\(ref)');
            if (carouselElement) {
                var carousel = new bootstrap.Carousel(carouselElement);
                carousel.to(\(index));
            }
            """
            
        case .accordionToggle(let ref):
            script += """
            var accordionElement = document.getElementById('\(ref)');
            if (accordionElement) {
                var accordion = new bootstrap.Collapse(accordionElement);
                accordion.toggle();
            }
            """
            
        case .progressSet(let ref, let value):
            script += """
            var progressElement = document.getElementById('\(ref)');
            if (progressElement) {
                var progressBar = progressElement.querySelector('.progress-bar');
                if (progressBar) {
                    progressBar.setAttribute('aria-valuenow', \(value));
                    progressBar.style.width = \(value) + '%';
                    var label = progressBar.querySelector('.progress-label');
                    if (label) {
                        label.textContent = \(value) + '%';
                    }
                }
            }
            """
            
        case .spinnerSet(let ref, let type, let size, let color, let label):
            script += """
            var spinnerElement = document.getElementById('\(ref)');
            if (spinnerElement) {
                spinnerElement.classList.remove('spinner-border', 'spinner-grow', 'spinner-border-sm', 'spinner-border-lg', 'spinner-grow-sm', 'spinner-grow-lg');
                spinnerElement.classList.add('\(type.rawValue)');
                if ('\(size.rawValue)' !== '') {
                    spinnerElement.classList.add('\(size.rawValue)');
                }
                spinnerElement.style.color = '\(color.rgba)';
                var labelElement = spinnerElement.querySelector('.sr-only');
                if (labelElement) {
                    labelElement.textContent = '\(label)';
                }
            }
            """
            
        case .handleResponse(let scriptContent):
            // This case is handled within the .post case to inject the response data
            break
            
            // Existing cases...
            
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
        case .post(url: let url, values: let values, onSuccessful: let onSuccessful, onFailed: let onFailed, onTimeout: let onTimeout, resultInto: let resultInto):
            let id = "\(UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "").prefix(4))"
            script += "var postData\(id) = {};\n"
            for value in values ?? [] {
                if let name = value.formName {
                    script += "postData\(id)['\(name)'] = \(value.builderId);\n"
                }
            }
            script += "var xhr\(id) = new XMLHttpRequest();\n"
            script += "xhr\(id).open('POST', '\(url ?? "")', true);\n"
            script += "xhr\(id).setRequestHeader('Content-Type', 'application/json');\n"
            script += "xhr\(id).overrideMimeType('text/html');\n"
            script += "xhr\(id).onreadystatechange = function() {\n"
            script += "if (xhr\(id).readyState == 4 && (xhr\(id).status == 200 || xhr\(id).status == 201 || xhr\(id).status == 202)) {\n"
            if let resultInto = resultInto {
                script += "\(resultInto.builderId) = xhr\(id).responseText;\n"
            }
            if let onSuccessful = onSuccessful {
                for action in onSuccessful {
                    if case .handleResponse(let scriptContent) = action {
                        script += """
                        {
                            var body = xhr\(id).responseText;
                            var status = xhr\(id).status;
                            var headers = xhr\(id).getAllResponseHeaders();
                            \(scriptContent)
                        }
                        """
                    } else {
                        script += CompileActions([action], builderId: builderId)
                    }
                }
            }
            script += "} else {\n"
            if let onFailed = onFailed {
                script += CompileActions(onFailed, builderId: builderId)
            }
            script += "}\n"
            script += "};\n"
            script += "xhr\(id).send(JSON.stringify(postData\(id)));\n"
        case .set(variable: let variable, input: let inputName, varName: let variableName, to: let to):
            
            if let variable = variable, let to = to {
                if let stringValue = to as? String {
                    script += "\(variable.builderId) = '\(stringValue)';\n"
                } else if let intValue = to as? Int {
                    script += "\(variable.builderId) = \(intValue);\n"
                } else if let doubleValue = to as? Double {
                    script += "\(variable.builderId) = \(doubleValue);\n"
                } else if let boolValue = to as? Bool {
                    script += "\(variable.builderId) = \(boolValue ? "true" : "false");\n"
                } else {
                    script += "\(variable.builderId) = '\(to)';\n"
                }
            } else if let inputName = inputName, let to = to {
                
                // this is going to set the value on an input by finding its name
                if let stringValue = to as? String {
                    script += "document.getElementsByName('\(inputName)')[0].value = '\(stringValue)';\n"
                } else if let intValue = to as? Int {
                    script += "document.getElementsByName('\(inputName)')[0].value = \(intValue);\n"
                } else if let doubleValue = to as? Double {
                    script += "document.getElementsByName('\(inputName)')[0].value = \(doubleValue);\n"
                } else if let boolValue = to as? Bool {
                    script += "document.getElementsByName('\(inputName)')[0].value = \(boolValue ? "true" : "false");\n"
                } else {
                    script += "document.getElementsByName('\(inputName)')[0].value = '\(to)';\n"
                }
                
            } else if let variableName = variableName, let to = to {
                
                // this will find a javascript var, which has a name property set.  For instance, it was created like this:
                // var myValue = 1234;
                // myValue.name = 'myName';
                if let stringValue = to as? String {
                    script += "set\(variableName.md5())('\(stringValue)');\n"
                } else if let intValue = to as? Int {
                    script += "set\(variableName.md5())(\(intValue));\n"
                } else if let doubleValue = to as? Double {
                    script += "set\(variableName.md5())(\(doubleValue));\n"
                } else if let boolValue = to as? Bool {
                    script += "set\(variableName.md5())(\(boolValue ? "true" : "false"));\n"
                } else {
                    script += "set\(variableName.md5())('\(to)');\n"
                }
                
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
            let ifScript = CompileActions(ifActions, builderId: builderId)
            if let elseActions = elseActions {
                let elseScript = CompileActions(elseActions, builderId: builderId)
                script += "if (\(variable.builderId) \(condition.javascriptCondition)) {\n\(ifScript)\n} else {\n\(elseScript)\n}\n"
            } else {
                script += "if (\(variable.builderId) \(condition.javascriptCondition)) {\n\(ifScript)\n}\n"
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
                        for color in WebStyle.all {
                            script += "document.getElementById('\(ref)').classList.remove('\(color.textStyleClass)');\n"
                        }
                        script += "document.getElementById('\(ref)').classList.add('\(style.textStyleClass)');\n"
                    case .button:
                        for color in WebStyle.all {
                            script += "document.getElementById('\(ref)').classList.remove('\(color.buttonStyleClass)');\n"
                        }
                        script += "document.getElementById('\(ref)').classList.add('\(style.buttonStyleClass)');\n"
                    case .link:
                        for color in WebStyle.all {
                            script += "document.getElementById('\(ref)').classList.remove('\(color.linkStyleClass)');\n"
                        }
                        script += "document.getElementById('\(ref)').classList.add('\(style.linkStyleClass)');\n"
                    case .image:
                        break
                    case .unknown:
                        break
                    }
                }
            } else {
                if let type = executionPipeline()?.types[builderId] {
                    switch type {
                    case .text:
                        for color in WebStyle.all {
                            script += "\(builderId).classList.remove('\(color.textStyleClass)');\n"
                        }
                        script += "\(builderId).classList.add('\(style.textStyleClass)');\n"
                    case .button:
                        for color in WebStyle.all {
                            script += "\(builderId).classList.remove('\(color.buttonStyleClass)');\n"
                        }
                        script += "\(builderId).classList.add('\(style.buttonStyleClass)');\n"
                    case .link:
                        for color in WebStyle.all {
                            script += "\(builderId).classList.remove('\(color.linkStyleClass)');\n"
                        }
                        script += "\(builderId).classList.add('\(style.linkStyleClass)');\n"
                    case .image:
                        break
                    case .unknown:
                        break
                    }
                }
            }
        case .random(let actions):
            let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
            script += "var randomIndex\(id) = Math.floor(Math.random() * \(actions.count));\n"
            script += "var functions\(id) = [];\n"
            for action in actions {
                script += "functions\(id).push(function() {\n"
                script += CompileActions([action], builderId: builderId)
                script += "});\n"
            }
            script += "functions\(id)[randomIndex\(id)]();\n"
        case .showModal(ref: let ref, contentURL: let contentURL):
            if let contentURL = contentURL {
                script += """
                fetch('\(contentURL)')
                    .then(response => response.text())
                    .then(data => {
                        document.getElementById('\(ref)').querySelector('.modal-body').innerHTML = data;
                        \(ref.md5().trimmingCharacters(in: CharacterSet.decimalDigits))ModalDialog.show();
                    });
                """
            } else {
                script += """
                if(\(ref.md5().trimmingCharacters(in: CharacterSet.decimalDigits))ModalDialog) {
                    \(ref.md5().trimmingCharacters(in: CharacterSet.decimalDigits))ModalDialog.show();
                }
                """
            }
        case .collapse(ref: let ref):
            script += """
            var myCollapse = new bootstrap.Collapse('#\(ref)', {
                hide: true
            });
            """
        case .hideModal(ref: let ref):
            script += """
            if(\(ref.md5().trimmingCharacters(in: CharacterSet.decimalDigits))ModalDialog) {
                \(ref.md5().trimmingCharacters(in: CharacterSet.decimalDigits))ModalDialog.hide();
            }
            """
        case .popover(title: let title, content: let content):
            script += """
            var popover = new bootstrap.Popover(\(builderId), {
                title: '\(title)',
                content: '\(content)'
            });
            popper.show();
            """
        case .src(ref: let ref, url: let url):
            if let ref = ref {
                script += "document.getElementById('\(ref)').src = '\(url)';\n"
            } else {
                script += "\(builderId).src = '\(url)';\n"
            }
        }
    }
    
    return script
}


extension GenericProperties {
    
    internal func compileActions(_ actions: [WebAction]) -> String {
        return CompileActions(actions, builderId: builderId)
    }
    
}

public enum ScrollBehavior: String {
    case auto
    case smooth
}

public enum ScrollAlignment: String {
    case start
    case center
    case end
    case nearest
}
