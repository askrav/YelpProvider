//
//  ReviewResponse.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/24/19.
//

import Foundation

public struct ReviewResponse: YelpModel {
    
    public var reviews: [ReviewModel]
    public var total: Int
    public var possibleLanguages: [String]
    
    public enum CodingKeys: String, CodingKey {
        case reviews
        case total
        case possibleLanguages = "possible_languages"
    }
}
