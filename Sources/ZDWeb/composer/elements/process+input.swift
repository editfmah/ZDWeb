//
//  process+input.swift
//  process+input
//
//  Created by Adrian Herridge on 13/09/2021.
//

import Foundation

public enum InputValidation {
    case Email 
}

public extension WebRequestContext {
    
    func textinput(name: String, value: String, title: String? = nil, validation: DataObjectValidation, _ closure: WebComposerClosure) {
        let id = UUID().uuidString.lowercased()
        if let title = title {
            self.output("<label for=\"\(id)\" class=\"form-label\">\(title)</label>")
        }
        self.block("input") {
            self.class("form-control")
            self.type("text")
            self.name(name)
            self.id(id)
            self.value(value)
            switch validation {
            case .none:
                break;
            case .required:
                self.tag(property: "required")
            }
        }
    }
    
    func textinput(_ closure: WebComposerClosure) {
        self.block("input") {
            self.type("text")
            closure()
        }
    }
    func textinput(name: String, value: String, _ closure: WebComposerClosure) {
        self.block("input") {
            self.type("text")
            self.name(name)
            self.id(name)
            self.value(value)
            closure()
        }
    }
    func textinput(name: String, value: String, placeholder: String, _ closure: WebComposerClosure) {
        self.block("input") {
            self.type("text")
            self.name(name)
            self.id(name)
            self.value(value)
            self.property(property: "placeholder", value: placeholder)
            closure()
        }
    }
    func textinput(name: String, value: String) {
        self.block("input") {
            self.type("text")
            self.name(name)
            self.value(value)
        }
    }
    func passwordinput(name: String, value: String) {
        self.block("input") {
            self.type("password")
            self.name(name)
            self.value(value)
        }
    }
    func filter(value: String, debounceChange: String) {
        self.block("input") {
            self.type("text")
            let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
            self.name(id)
            self.id(id)
            self.value(value)
            self.script(
"""
$("#\(id)").on("keyup", debounce\(id)(fn, 300));
function fn() {
    var newValue = $('#\(id)').val();
    \(debounceChange)
}
function debounce\(id)( fn, threshold ) {
    var timeout;
    return function debounced() {
        if ( timeout ) {
            clearTimeout( timeout );
        }
        function delayed() {
            fn();
            timeout = null;
        }
        timeout = setTimeout( delayed, threshold || 100 );
    };
}
""")
        }
    }
    func checkbox(name: String, value: Bool) {
        self.block("input") {
            self.type("checkbox")
            self.style(.raw(value: "width: 30px;"))
            self.name(name)
            self.id(name)
            if value {
                self.elementProperties[blocks.last!]!["checked"] = "true"
            }
        }
    }
    func CheckBox(name: String, title: String, value: Bool, onCheck: String? = nil) {
        self.div("mb-3 mt-3") {
            self.block("input") {
                self.type("checkbox")
                self.class("form-check-input")
                self.name(name)
                self.id(name)
                if value {
                    self.property(property: "value", value: "on")
                    self.tag(property: "checked")
                }
                if let onCheck = onCheck {
                    self.onClick(onCheck)
                }
            }
            self.label {
                self.class("form-check-label ms-2")
                self.text(title)
            }
        }
    }
    func CheckBox(name: String, value: Bool, `class`: String, onCheck: String, _ closure: WebComposerClosure? = nil) {
        self.block("input") {
            self.type("checkbox")
            self.class("form-check-input \(`class`)")
            self.name(name)
            self.id(name)
            if value {
                self.property(property: "value", value: "on")
                self.tag(property: "checked")
            }
            self.onClick(onCheck)
            if let closure = closure {
                closure()
            }
        }
    }
    func radio(group: String, value: String, label: String? = nil, selected: Bool) {
        /*
         
         <div class="form-check">
           <input type="radio" class="form-check-input" id="radio1" name="optradio" value="option1" checked>Option 1
           <label class="form-check-label" for="radio1"></label>
         </div>
         
         */
        
        self.div("form-check") {
            self.block("input") {
                self.type("radio")
                self.class("form-check-input")
                self.id(value.lowercased().replacingOccurrences(of: " ", with: ""))
                self.name(group)
                self.value(value)
                if selected {
                    self.tag(property: "checked")
                }
            }
        }
    }
    func segment(style: Style, group: String, value: String, label: String? = nil, selected: Bool, onSelect: String? = nil, body: WebComposerClosure) {
        /*
         
         <input type="radio" class="btn-check" name="options" id="option1" autocomplete="off" checked>
         <label class="btn btn-secondary" for="option1">Checked</label>
         
         */
        
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        
        self.block("input") {
            self.type("radio")
            self.class("btn-check")
            self.id(id)
            self.property(property: "autocomplete", value: "off")
            self.name(group)
            self.value(value)
            if selected {
                self.tag(property: "checked")
            }
        }
        self.label {
            self.class("btn btn-\(style.rawValue)")
            self.property(property: "for", value: id)
            body()
            if let onSelect = onSelect {
                self.onClick(onSelect)
            }
        }
        
    }
    func segmentedControl(values: [String], selected: String, fieldId: String, onChange: String) {
        
        self.hidden(name: fieldId, value: selected)
        let id = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        
        for v in values {
            let vId = (v+id)
            var others: [String] = []; values.forEach({ if $0 != v { others.append($0+id) } })
            var script = ""

            for o in others {
                script += """
$('#\(o)').css('border', "none");
"""
            }
            script += """
$('#\(vId)').css('border', "solid 2px blue");
"""

            script += """

$('#\(fieldId)').val('\(v)');

\(onChange)

"""
            self.button(vId,v, script: script)
            if v == selected {
                // set this button to highlighted
                
            }
        }
        
    }
    func hidden(name: String, value: String, id: String? = nil) {
        self.block("input") {
            self.type("hidden")
            self.name(name)
            if let id = id {
                self.id(name)
            } else {
                self.id(name)
            }
            self.value(value)
        }
    }
    func label(_ closure: WebComposerClosure) {
        self.block("label") {
            closure()
        }
    }
    func fieldset(_ closure: WebComposerClosure) {
        self.block("fieldset") {
            closure()
        }
    }
    func colour(name: String, value: String, _ closure: WebComposerClosure? = nil) {
        self.block("input") {
            self.type("color")
            self.name(name)
            self.id(name)
            self.value(value)
            if let closure = closure {
                closure()
            }
        }
    }
    
}

public enum TextFieldType {
    case Text
    case Email
    case Password
    case TextRO
    case Memo
}

public enum FieldMargin: String {
    case None = "mb-0 mt-0"
    case Small = "mb-1 mt-1"
    case Medium = "mb-3 mt-3"
}

public class DataFormFields {
    
    var c: WebRequestContext
    public init(context: WebRequestContext) {
        self.c = context
    }
    
    public func Text(type: TextFieldType, name: String, label: String? = nil, placeholder: String? = nil, value: String? = nil, id: String? = nil, validation: DataObjectValidation? = nil, margins: FieldMargin? = .Medium, debounce: String? = nil, padding: String? = nil) {
        
        let id = id ?? UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        
        c.div(margins?.rawValue ?? "mb-3 mt-3") {
            if let label = label {
                c.block("label") {
                    c.property(property: "for", value: id)
                    c.class("form-label")
                    c.text(label)
                }
            }
            switch type {
            case .Memo:
                var text = ""
                text += "<textarea class=\"form-control\" rows=\"10\" id=\"\(id)\" name=\"\(name)\""
                if let placeholder = placeholder {
                    text += " placeholder=\"\(placeholder)\""
                }
                if let validation = validation {
                    switch validation {
                    case .none:
                        break;
                    case .required:
                        text += " required"
                    }
                }
                text += ">"
                if let value = value, !value.isEmpty {
                    text += value
                }
                text += "</textarea>"
                c.text(text)
            case .Text:
                c.block("input") {
                    c.property(property: "type", value: "text")
                    c.class("form-control " + (padding ?? ""))
                    c.id(id)
                    if let placeholder = placeholder {
                        c.property(property: "placeholder", value: placeholder)
                    }
                    c.property(property: "name", value: name)
                    if let value = value {
                        c.property(property: "value", value: value)
                    }
                    if let validation = validation {
                        switch validation {
                        case .none:
                            break;
                        case .required:
                            c.tag(property: "required")
                        }
                    }
                }
            case .TextRO:
                c.hidden(name: name, value: value ?? "")
                c.block("input") {
                    c.property(property: "type", value: "text")
                    c.tag(property: "disabled")
                    c.class("form-control")
                    c.id(id)
                    if let placeholder = placeholder {
                        c.property(property: "placeholder", value: placeholder)
                    }
                    if let value = value {
                        c.property(property: "value", value: value)
                    }
                    if let validation = validation {
                        switch validation {
                        case .none:
                            break;
                        case .required:
                            c.tag(property: "required")
                        }
                    }
                }
            case .Email:
                c.block("input") {
                    c.property(property: "type", value: "email")
                    c.class("form-control")
                    c.id(id)
                    if let placeholder = placeholder {
                        c.property(property: "placeholder", value: placeholder)
                    }
                    c.property(property: "name", value: name)
                    if let value = value {
                        c.property(property: "value", value: value)
                    }
                }
            case .Password:
                c.block("input") {
                    c.property(property: "type", value: "password")
                    c.class("form-control")
                    c.id(id)
                    if let placeholder = placeholder {
                        c.property(property: "placeholder", value: placeholder)
                    }
                    c.property(property: "name", value: name)
                    if let value = value {
                        c.property(property: "value", value: value)
                    }
                    if let validation = validation {
                        switch validation {
                        case .none:
                            break;
                        case .required:
                            c.tag(property: "required")
                        }
                    }
                }
            }
            if let debounce = debounce {
                c.script(
    """
    $("#\(id)").on("keyup", debounce\(id)(fn, 300));
    function fn() {
        var newValue = $('#\(id)').val();
        \(debounce)
    }
    function debounce\(id)( fn, threshold ) {
        var timeout;
        return function debounced() {
            if ( timeout ) {
                clearTimeout( timeout );
            }
            function delayed() {
                fn();
                timeout = null;
            }
            timeout = setTimeout( delayed, threshold || 100 );
        };
    }
    """)
            }
        }
        
    }
    
    
    public func Date(name: String, label: String? = nil, value: Date? = nil, id: String? = nil, validation: DataObjectValidation? = nil) {
        
        let id = id ?? UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        
        c.div("mb-3 mt-3") {
            if let label = label {
                c.block("label") {
                    c.property(property: "for", value: id)
                    c.class("form-label")
                    c.text(label)
                }
            }
            c.block("input") {
                c.property(property: "type", value: "date")
                c.class("form-control")
                c.id(id)
                c.property(property: "name", value: name)
                if let value = value {
                    c.property(property: "value", value: value.isoDate)
                }
                if let validation = validation {
                    switch validation {
                    case .none:
                        break;
                    case .required:
                        c.tag(property: "required")
                    }
                }
            }
        }
        
    }
    
    public func DateTime(name: String, label: String? = nil, value: Date? = nil, id: String? = nil, validation: DataObjectValidation? = nil) {
        
        let id = id ?? UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        
        c.div("mb-3 mt-3") {
            if let label = label {
                c.block("label") {
                    c.property(property: "for", value: id)
                    c.class("form-label")
                    c.text(label)
                }
            }
            c.block("input") {
                c.property(property: "type", value: "datetime-local")
                c.class("form-control")
                c.id(id)
                c.property(property: "name", value: name)
                if let value = value {
                    c.property(property: "value", value: value.isoDateWithHoursMinutes)
                }
                if let validation = validation {
                    switch validation {
                    case .none:
                        break;
                    case .required:
                        c.tag(property: "required")
                    }
                }
            }
        }
        
    }
    
    public func Time(name: String, label: String? = nil, value: String? = nil, id: String? = nil, validation: DataObjectValidation? = nil) {
        
        let id = id ?? UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        
        c.div("mb-3 mt-3") {
            if let label = label {
                c.block("label") {
                    c.property(property: "for", value: id)
                    c.class("form-label")
                    c.text(label)
                }
            }
            c.block("input") {
                c.property(property: "type", value: "date")
                c.class("form-control")
                c.id(id)
                c.property(property: "name", value: name)
                if let value = value {
                    c.property(property: "value", value: value)
                }
                if let validation = validation {
                    switch validation {
                    case .none:
                        break;
                    case .required:
                        c.tag(property: "required")
                    }
                }
            }
        }
        
    }
    
    public func Combo(name: String, label: String? = nil, options: [String], value: String? = nil, id: String? = nil, validation: DataObjectValidation? = nil,_ onChangeAsValue: String? = nil, padding: String? = nil) {
        
        let id = id ?? UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        var classString = "mb-3 mt-3"
        if label == nil {
            classString = ""
        }
        c.div(classString) {
            if let label = label {
                c.block("label") {
                    c.property(property: "for", value: id)
                    c.class("form-label")
                    c.text(label)
                }
            }
            c.block("select") {
                c.class("form-select " + (padding ?? "") )
                c.id(id)
                c.name(name)
                for v in options {
                    c.block("option") {
                        if v == value {
                            c.tag(property: "selected")
                        }
                        c.text(v)
                    }
                }
                if let validation = validation {
                    switch validation {
                    case .none:
                        break;
                    case .required:
                        c.tag(property: "required")
                    }
                }
            }
        }
        
    }
    
    public func Combo(name: String, label: String? = nil, optionsBuilder: ( () -> [(String,String)] ), value: Any? = nil, id: String? = nil, validation: DataObjectValidation? = nil) {
        
        let options = optionsBuilder()
        
        var strValue: String!
        if let v = value as? UUID {
            strValue = v.uuidString
        } else if let v = value as? String {
            strValue = v
        } else if let v = value as? Int {
            strValue = "\(v)"
        } else if let v = value as? Double {
            strValue = "\(v)"
        } else if value == nil {
            strValue = ""
        } else {
            assertionFailure("error: invalid value type passed into WebProcess.Fields.Combo:value:")
        }
        
        let id = id ?? UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        var classString = "mb-3 mt-3"
        if label == nil {
            classString = ""
        }
        c.div(classString) {
            if let label = label {
                c.block("label") {
                    c.property(property: "for", value: id)
                    c.class("form-label")
                    c.text(label)
                }
            }
            c.block("select") {
                c.class("form-select")
                c.id(id)
                c.name(name)
                for v in options {
                    c.block("option") {
                        if value != nil && (v.0 == strValue || v.1 == strValue) {
                            c.tag(property: "selected")
                        }
                        c.value(v.0)
                        c.text(v.1)
                    }
                }
                if let validation = validation {
                    switch validation {
                    case .none:
                        break;
                    case .required:
                        c.tag(property: "required")
                    }
                }
            }
        }
        
    }
    
}

fileprivate extension Date {
    
    var milliseconds : UInt64 {
        return UInt64((self.timeIntervalSince1970 * 1000))
    }
    var seconds: UInt64 {
        return UInt64(self.timeIntervalSince1970)
    }
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        dateformat.timeZone = TimeZone(identifier: "UTC")
        return dateformat.string(from: self)
    }
    var isoFullDate: String {
        return getFormattedDate(format: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
    var isoYear: String {
        return getFormattedDate(format: "yyyy")
    }
    var isoMonth: String {
        return getFormattedDate(format: "yyyy-MM")
    }
    var isoDate: String {
        return getFormattedDate(format: "yyyy-MM-dd")
    }
    var isoDateWithTime: String {
        return getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
    }
    var isoTime: String {
        return getFormattedDate(format: "HH:mm:ss")
    }
    var isoDateWithHour: String {
        return getFormattedDate(format: "yyyy-MM-dd HH")
    }
    var isoDateWithHoursMinutes: String {
        return getFormattedDate(format: "yyyy-MM-dd HH:mm")
    }
    
    
    // localised for the user
    func userDate() -> String {
        return self.isoDate
    }
    
    func userDateTime() -> String {
        return ""
    }
    
    static func from(string: String) -> Date? {
        
        let dateString = string
        
        // right try and cobble something together to sort out this damned mixed date issue
        let components = dateString.components(separatedBy: CharacterSet(charactersIn: "T "))
        if components.count > 0 {
            let datePart = components[0]
            
            let dateComponents = datePart.components(separatedBy: CharacterSet(charactersIn: "-/\\|:."))
            
            if dateComponents.count > 2 {
                
                if let year = Int(dateComponents[0]), let month = Int(dateComponents[1]), let day = Int(dateComponents[2]) {
                    // we have our date parts
                    
                    var hours = 0
                    var minutes = 0
                    var seconds = 0
                    
                    if components.count > 1 {
                        let timePart = components[1]
                        
                        var timeComponents = timePart.components(separatedBy: CharacterSet(charactersIn: "-/\\|:."))
                        
                        if let hrs = timeComponents.first, let h = Int(hrs) {
                            timeComponents.removeFirst()
                            hours = h
                        }
                        
                        if let mins = timeComponents.first, let m = Int(mins) {
                            timeComponents.removeFirst()
                            minutes = m
                        }
                        
                        if let secs = timeComponents.first, let s = Int(secs) {
                            timeComponents.removeFirst()
                            seconds = s
                        }
                    }
                    
                    var calendar = Calendar(identifier: .gregorian)
                    calendar.timeZone = TimeZone(abbreviation: "UTC")!
                    let components = DateComponents(year: year, month: month, day: day, hour: hours, minute: minutes, second: seconds)
                    
                    if let newDate = calendar.date(from: components) {
                        return newDate
                    }
                    
                }
            }
            
        }
        
        return nil
    }
    
    
}
