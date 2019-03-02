//
//  BusinessModel.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Foundation

public struct BusinessModel: YelpModel {
    
    public var id: String
    public var name: String
    
    public var price: String?
    public var rating: Double?

    public var categories: [CategoryShort]?
    public var coordinates: CoordinatesModel
    
    public var phone: String
    public var displayPhone: String
    public var distance: Double?
    public var alias: String?
    public var imageUrl: String?
    public var isClosed: Bool?
    public var reviewCount: Int?
    public var url: String?
    
    public var location: BusinessLocation
    
    public var transactions: [String]?
    
    public var isClaimed: Bool?
    public var photos: [String]?
    
    public var hours: [BusinessHours]?
    public var specialHours: [BusinessSpecialHour]?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case categories
        case coordinates
        case phone
        case displayPhone = "display_phone"
        case distance
        case alias
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case location
        case price
        case rating
        case reviewCount = "review_count"
        case url
        case transactions
        case isClaimed = "is_claimed"
        case photos
        case hours
        case specialHours = "special_hours"
    }
}

public struct Businesses: YelpModel {
    
    var businesses: [BusinessModel]
    
    public enum CodingKeys: String, CodingKey {
        case businesses
    }
}
