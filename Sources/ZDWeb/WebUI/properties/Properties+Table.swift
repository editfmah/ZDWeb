//
//  File.swift
//  
//
//  Created by Adrian Herridge on 23/07/2024.
//

import Foundation

extension GenericTableProperties {
    
    public func bordered() -> Self {
        addClass("table-bordered")
        return self
    }
    
    public func borderless() -> Self {
        addClass("table-borderless")
        return self
    }
    
    public func striped() -> Self {
        addClass("table-striped")
        return self
    }
    
    public func hover() -> Self {
        addClass("table-hover")
        return self
    }
    
    public func dark() -> Self {
        addClass("table-dark")
        return self
    }
    
    public func small() -> Self {
        addClass("table-sm")
        return self
    }
    
    public func responsive() -> Self {
        addClass("table-responsive")
        return self
    }
}
