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
            self.script(builderScripts.joined(separator: "\n"))
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
