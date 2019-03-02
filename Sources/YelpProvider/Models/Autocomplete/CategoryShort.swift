//
//  CategoryAutocomplete.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Foundation

public struct CategoryShort: YelpModel {
    
    public var alias: String
    public var title: String?
    
    public enum CodingKeys: String, CodingKey {
        case alias
        case title
    }
}
