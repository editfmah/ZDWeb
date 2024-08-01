//
//  process+script.swift
//  process+script
//
//  Created by Adrian Herridge on 08/09/2021.
//

import Foundation

public extension WebRequestContext {
    func script(_ scriptString: String) {
        self.block("script") {
            self.type("text/javascript")
            self.output(scriptString)
        }
    }
    func builderScript(_ scriptString: String) {
        self.builderScripts.append(scriptString)
    }
    func compileBuilderScripts() {
        if self.builderScripts.isEmpty == false {
            // first off, filter out all the lines which are factory definitions of objects and ensure they are scoped for all future code
            let definitions = builderScripts.filter({ $0.hasPrefix("/* builder-object-reference */")}).map({ $0.replacingOccurrences(of: "/* builder-object-reference */ ", with: "")})
            let remaining = builderScripts.filter({ $0.hasPrefix("/* builder-object-reference */") == false })
            self.script(definitions.joined(separator: "\n"))
            self.script(remaining.joined(separator: "\n"))
        }
        self.builderScripts.removeAll()
    }
    func script(url: String) {
        self.output("<script src=\"\(url)\"></script>")
    }
    func debounce(id: String, debounce: String) {
        self.script(
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
