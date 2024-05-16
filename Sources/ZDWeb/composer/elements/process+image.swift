//
//  process+image.swift
//  process+image
//
//  Created by Adrian Herridge on 09/09/2021.
//

import Foundation

public enum ImageCrop {
    case none
    case centre
    case top
    case bottom
    case left
    case right
    var style: String {
        get {
            switch self {
            case .none:
                return ""
            case .centre:
                return "object-fit: cover; object-position: center;"
            case .top:
                return ""
            case .bottom:
                return ""
            case .left:
                return "object-fit: cover; object-position: left;"
            case .right:
                return "object-fit: cover; object-position: right;"
            }
        }
    }
}

public extension WebRequestContext {
    func image(url: String) {
        self.output("<img src=\"\(url)\" alt=\"\" />")
    }
    func image(class: String) {
        self.output("<img class=\"\(`class`)\"/>")
    }
    func image(url: String, id: String? = nil, class: String? = nil, width: Int? = nil, height: Int? = nil, crop: ImageCrop? = nil, onClick: String? = nil, onSelection: String? = nil) {
        var oString = "<img src=\"\(url)\" alt=\"\" "
        let id = id ?? "img\(UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: ""))"
        oString += " id=\"\(id)\""
        if let `class` = `class` {
            oString += " class=\"\(`class`)\""
        }
        if let width = width, let height = height {
            oString += "style=\"width: \(width)px; height: \(height)px; \(crop?.style ?? "") \""
        } else if let width = width {
            oString += "style=\"width: \(width)px; \(crop?.style ?? "") \""
        } else if let height = height {
            oString += "style=\"height: \(height)px; \(crop?.style ?? "") \""
        }
        oString += " />"
        self.output(oString)
        if let onClick = onClick {
            self.script("""
$("#\(id)").on("click", function() {
   \(onClick)
});
""")
        }
    }
    func image(url: String, widthPc: Int, crop: ImageCrop) {
        self.output("<img style=\"max-width: \(widthPc)%; \(crop.style)\" src=\"\(url)\">")
    }
    func image(url: String, height: Int, crop: ImageCrop) {
        self.output("<img style=\"height: \(height)px; \(crop.style)\" src=\"\(url)\">")
    }
    func image(id: String, url: String, width: Int, height: Int, crop: ImageCrop) {
        self.output("<img id=\"\(id)\" style=\"width: \(width)px; height: \(height)px; \(crop.style)\" src=\"\(url)\">")
    }
}
