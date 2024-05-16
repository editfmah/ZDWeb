//
//  process+style.swift
//  process+style
//
//  Created by Adrian Herridge on 08/09/2021.
//

import Foundation

public extension WebRequestContext {
    func stylesheet(_ styleString: String) {
        self.block("style") {
            self.output(styleString)
        }
    }
    func stylesheet(url: String) {
        self.link(rel: "stylesheet", ref: url, type: "text/css")
    }
}
