//
//  WebData.swift
//  WebData
//
//  Created by Adrian Herridge on 13/09/2021.
//

import Foundation

public struct WebFile {
    public var data: Data?
    public var filename: String?
    public var type: String?
    public var name: String?
    public var headers: [String:String]?
}

public class AJAXJsonForm : Codable {
    public var name: String
    public var value: String?
}

public class AJAXFormResponse : Codable {
    public init(success: Bool, errors: [String:String], redirectUrl: String? = nil) {
        self.success = success
        self.errors = errors
        self.redirectUrl = redirectUrl
    }
    public var redirectUrl: String?
    public var success: Bool = false
    public var errors: [String:String] = [:]
}

public class WebRequestData {
    
    public var httpRequest: HttpRequest
    public var params: [String:String] = [:]
    public var headers: [String:String] = [:]
    public var data: [String:String] = [:]
    
    public init(_ request: HttpRequest) {
        
        self.httpRequest = request
        for qp in request.queryParams {
            params[qp.0.lowercased()] = qp.1
            data[qp.0.lowercased()] = qp.1
        }
        self.headers = request.headers
        for h in request.headers {
            data[h.key.lowercased()] = h.value
        }
        
        let d = request.parseUrlencodedForm()
        for formData in d {
            data[formData.key.lowercased()] = formData.value
        }
        
        // now go deep if the content type is application/json
        if let type = headers["content-type"], type.contains("json") {
            let bodyData = Data(request.body)
            if let jsonObject = try? JSONSerialization.jsonObject(with: bodyData) {
                if let o = jsonObject as? [String:Any] {
                    for kvp in o {
                        if let value = kvp.value as? String {
                            if data[kvp.key.lowercased()] == nil {
                                data[kvp.key.lowercased()] = "\(value)"
                            }
                        } else if let value = kvp.value as? Double {
                            if data[kvp.key.lowercased()] == nil {
                                data[kvp.key.lowercased()] = "\(value)"
                            }
                        } else if let value = kvp.value as? Int {
                            if data[kvp.key.lowercased()] == nil {
                                data[kvp.key.lowercased()] = "\(value)"
                            }
                        } else if let value = kvp.value as? Bool {
                            if data[kvp.key.lowercased()] == nil {
                                data[kvp.key.lowercased()] = "\(value)"
                            }
                        } else if let value = kvp.value as? [String] {
                            if data[kvp.key.lowercased()] == nil {
                                data[kvp.key.lowercased()] = "\(value.joined(separator: "|"))"
                            }
                        }
                    }
                } else if let ajax = try? JSONDecoder().decode([AJAXJsonForm].self, from: bodyData) {
                    for field in ajax {
                        if let value = field.value {
                            data[field.name.lowercased()] = value
                        }
                    }
                }
            }
        }
    
    }
    
    public var files: [WebFile]? {
        get {
            if httpRequest.parseMultiPartFormData().isEmpty {
                return nil
            }
            var fs: [WebFile] = []
            for mpfd in httpRequest.parseMultiPartFormData() {
                if mpfd.fileName != nil && mpfd.fileName!.isEmpty == false {
                    fs.append(WebFile(data: Data(mpfd.body), filename: mpfd.fileName, type: mpfd.type, name: mpfd.name, headers: mpfd.headers))
                }
            }
            return fs
        }
    }
    
    public func ifString(_ param: String,_ closure: ((_ value: String) -> Void), not: (() -> Void)? = nil) {
        if let value = data[param.lowercased()] {
            closure(value)
        } else {
            if let not = not {
                not()
            }
        }
    }
    
    public func ifNot(_ param: String,_ closure: (() -> Void)) {
        if  data[param.lowercased()] == nil {
            closure()
        }
    }
    
    public func ifBool(_ param: String,_ closure: ((_ value: Bool) -> Void)) {
        if let value = data[param.lowercased()] {
            if ["true","on"].contains(value) {
                closure(true)
            } else {
                closure(false)
            }
        }
    }
    
    public func ifUUID(_ param: String,_ closure: ((_ value: UUID?) -> Void)) {
        if let value = data[param.lowercased()] {
            if let uValue = UUID(uuidString: value) {
                closure(uValue)
            } else {
                closure(nil)
            }
        }
    }
    
    public func ifInt(_ param: String,_ closure: ((_ value: Int) -> Void)) {
        if let value = data[param.lowercased()] {
            if let intValue = Int(value) {
                closure(intValue)
            } else {
                closure(0)
            }
        }
    }
    
    public func ifNumber(_ param: String,_ closure: ((_ value: Double) -> Void)) {
        if let value = data[param.lowercased()] {
            if let doubleValue = Double(value) {
                closure(doubleValue)
            } else {
                closure(0)
            }
        }
    }
    
    public func ifDate(_ param: String,_ closure: ((_ value: Date) -> Void)) {
        if let value = data[param.lowercased()] {
            // parse out this date as best we can
            if let dateValue = Date.from(string: value) {
                closure(dateValue)
            }
        }
    }
    
    public func string(_ param: String,_ closure: ((_ value: String) -> Void)) {
        if let value = data[param.lowercased()] {
            closure(value)
        } else {
            closure("")
        }
    }
    
    public func string(_ param: String) -> String? {
        if let value = data[param.lowercased()] {
            return value
        }
        return nil
    }
    
    public func uuid(_ param: String) -> UUID? {
        if let value = data[param.lowercased()], let uuid = UUID(uuidString: value) {
            return uuid
        }
        return nil
    }
    
    public func bool(_ param: String) -> Bool {
        if let value = data[param.lowercased()] {
            if let v = Bool(value) {
                return v
            }
            if let v = Double(value) {
                return v > 0
            }
            if let v = Int(value) {
                return v > 0
            }
        }
        return false
    }
    
    public func bool(_ param: String,_ closure: ((_ value: Bool) -> Void)) {
        if let value = data[param.lowercased()] {
            if ["true","on","1","1.0"].contains(value) {
                closure(true)
            } else {
                closure(false)
            }
        } else {
            closure(false)
        }
    }
    
    public func int(_ param: String,_ closure: ((_ value: Int) -> Void)) {
        if let value = data[param.lowercased()] {
            if let intValue = Int(value) {
                closure(intValue)
            } else {
                closure(0)
            }
        } else {
            closure(0)
        }
    }
    
    public func number(_ param: String,_ closure: ((_ value: Double) -> Void)) {
        if let value = data[param.lowercased()] {
            if let doubleValue = Double(value) {
                closure(doubleValue)
            } else {
                closure(0.0)
            }
        } else {
            closure(0.0)
        }
    }
    
    public func exists(_ param: String) -> Bool {
        if let _ = data[param.lowercased()] {
            return true
        } else {
            return false
        }
    }
    
    public func hasValue(_ param: String) -> Bool {
        if let value = data[param.lowercased()], value.isEmpty == false {
            return true
        } else {
            return false
        }
    }
    
    enum `InspectionType` {
        case String
        case Int
        case Bool
        case Double
        case UUID
        case Date
        case Unset
    }
    
//    public func merge<T: Codable, Value>(object: T, keyPath: ReferenceWritableKeyPath<T, Value>, compiledValue: Value? = nil) where Value: Equatable {
//    
//        let pathStr = "\(keyPath)"
//        
//        if let compiledValue = compiledValue {
//            
//            object[keyPath: keyPath] = compiledValue
//            
//        } else {
//            
//            let optional = pathStr.contains(".Optional")
//            var type: InspectionType!
//            var property =
//            
//            if pathStr.contains(".String") {
//                type = .String
//            } else if pathStr.contains(".Int") {
//                type = .Int
//            } else if pathStr.contains(".Bool") {
//                type = .Bool
//            } else if pathStr.contains(".Double") {
//                type = .Double
//            } else if pathStr.contains(".UUID") {
//                type = .UUID
//            } else if pathStr.contains(".Date") {
//                type = .Date
//            } else {
//                assertionFailure("undeclared type for `\(pathStr)` use the compiledValue: option to pass in the correct value")
//            }
//            
//            switch type {
//            case .String:
//                
//            }
//            
//        }
//    }
    
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
