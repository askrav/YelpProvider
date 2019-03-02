//
//  CategoryModel.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Foundation

public struct CategoryModel: YelpModel {
    
    public var alias: String
    public var title: String
    public var parentAliases: [String]
    public var countryWhitelist: [String]
    public var countryBlacklist: [String]
    
    public enum CodingKeys: String, CodingKey {
        case alias
        case title
        case parentAliases = "parent_aliases"
        case countryWhitelist = "country_whitelist"
        case countryBlacklist = "country_blacklist"
    }
}

public struct CategoriesResponse: YelpModel {
    
    public var categories: [CategoryModel]
    
    public enum CodingKeys: String, CodingKey {
        case categories
    }
}

public struct CategoryResponse: YelpModel {
    
    public var category: CategoryModel
    
    public enum CodingKeys: String, CodingKey {
        case category
    }
}
