//
//  string+md5.swift
//  
//
//  Created by Adrian Herridge on 12/02/2024.
//

import Foundation
import CryptoSwift

extension String {
    var md5: String {
        return self.md5()
    }
}
