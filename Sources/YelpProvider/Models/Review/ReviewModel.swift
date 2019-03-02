//
//  ReviewModel.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/24/19.
//

import Foundation

public struct ReviewModel: YelpModel {
    
    public var id: String
    public var rating: Int
    public var text: String
    public var timeCreated: String
    public var url: String
    
    public var user: ReviewUser
    
    public enum CodingKeys: String, CodingKey {
        case id
        case rating
        case text
        case timeCreated = "time_created"
        case url
        case user
    }
}

public struct ReviewUser: YelpModel {
    
    public var id: String
    public var profileUrl: String
    public var imageUrl: String?
    public var name: String
    
    public enum CodingKeys: String, CodingKey {
        case id
        case profileUrl = "profile_url"
        case imageUrl = "image_url"
        case name
    }
}
