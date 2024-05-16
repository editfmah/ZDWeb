//
//  process+form.swift
//  process+form
//
//  Created by Adrian Herridge on 10/09/2021.
//

import Foundation

public extension WebRequestContext {
    
    enum DynamicFooterComponents {
        case DeleteButton(Style, String)
        case CancelButton(Style, String)
        case SubmitButton(Style, String)
        case CloseButton(Style, String)
        case StatusObject
        case ActivityIndicator(Style)
    }
    
    func form(action: String, method: String = "POST", _ closure: WebComposerClosure) {
        self.output("<form action=\"\(action)\" method=\"\(method)\">")
        closure()
        self.output("</form>")
    }
    @discardableResult
    func DynamicForm(url: String, controls: [DynamicFooterComponents], _ closure: WebComposerClosure) -> String {
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        self.output("<form id=\"\(id)\">")
        closure()
        if controls.isEmpty == false {
            let link = WebNavigationPosition(self)
            self.row {
                for c in controls {
                    switch c {
                    case .DeleteButton(let style, let title):
                        self.column(.none) {
                            link.setAction(.Delete)
                            self.button(style: style, title: title, link: link)
                        }
                    case .CancelButton(let style, let title):
                        self.column(.none) {
                            link.setAction(.Content)
                            self.button(style: style, title: title, link: link)
                        }
                    case .CloseButton:
                        break;
                    case .SubmitButton(let style, let title):
                        self.column(.none) {
                            link.setAction(.Save)
                            self.button(style: style, title: title, script: "submit\(id)()")
                        }
                        self.script("""
function submit\(id)() {
    var data = JSON.stringify($("#\(id)").serializeArray())
    $.post({
        url: "\(url)",
        data: data,
        contentType: 'application/json; charset=utf-8',
        dataType:"json"
    })
    .always(function (response) {
        //Do something on success response...
        var value = response
        if(value.success == null) {
            value = response.responseJSON;
        }
        if (value.success == true) {
            if (value.redirectUrl != null) {
                var url = value.redirectUrl;
                window.location.href = url;
            }
        } else {
            // failure, look for error markers to be shown
            var errors = value.errors
            var form = $("#\(id)")
            if(form != null) {
                form\(id)ErrorsHandler(form, errors)
            }
        }
    });
}

function form\(id)ErrorsHandler(form, errors) {

    $("p.error").remove();

    form.find('input, textarea, select').each(function(){
        var error = errors[$(this).attr("name")] ? errors[$(this).attr("name")] : null;
        if(error) {
            $(this).addClass("border")
            $(this).addClass("border-danger")
            $(this).after('<p class="error text-danger">' + error + '</p>');
        } else {
            $(this).removeClass("border")
            $(this).removeClass("border-danger")
        }
    });
}
""")
                    case .StatusObject:
                        break;
                    case .ActivityIndicator:
                        break;
                    }
                }
            }
        }
        self.output("</form>")
        return id
    }
}
