//
//  YelpError.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Vapor

public struct YelpError: YelpModel, Error, Debuggable {
    
    public var identifier: String {
        return self.error.code
    }
    
    public var reason: String {
        return self.error.description
    }
    
    public var error: YelpAPIError
}

public struct YelpAPIError: YelpModel {
    
    public var code: String
    public var description: String
    public var field: String?
    public var instance: String?
    
    public enum CodingKeys: String, CodingKey {
        case code
        case description
        case field
        case instance
    }
}
