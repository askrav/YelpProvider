//
//  AutocompleteModel.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Foundation

public struct AutocompleteModel: YelpModel {
    
    public var terms: [Term]
    public var businesses: [BusinessShort]
    public var categories: [CategoryShort]
    
    public enum CodingKeys: String, CodingKey {
        case terms
        case businesses
        case categories
    }
}

public struct Term: YelpModel {
    
    public var text: String
    
    public enum CodingKeys: String, CodingKey {
        case text
    }
}
