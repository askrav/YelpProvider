//
//  EventModel.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/24/19.
//

import Foundation

public struct EventModel: YelpModel {
    
    public var id: String
    public var attendingCount: Int
    public var category: String
    public var description: String
    public var eventSiteUrl: String?
    public var imageUrl: String?
    public var cost: Double?
    public var costMax: Double?
    public var interestedCount: Int
    public var isCanceled: Bool
    public var isFree: Bool
    public var isOfficial: Bool
    public var latitude: Double
    public var longitude: Double
    public var name: String
    public var ticketsUrl: String?
    public var timeStart: String?
    public var timeEnd: String?
    public var businessId: String?
    public var location: BusinessLocation
    
    public enum CodingKeys: String, CodingKey {
        case id
        case attendingCount = "attending_count"
        case category
        case description
        case eventSiteUrl = "event_site_url"
        case imageUrl = "image_url"
        case cost
        case costMax = "cost_max"
        case interestedCount = "interested_count"
        case isCanceled = "is_canceled"
        case isFree = "is_free"
        case isOfficial = "is_official"
        case latitude
        case longitude
        case name
        case ticketsUrl = "tickets_url"
        case timeStart = "time_start"
        case timeEnd = "time_end"
        case businessId = "business_id"
        case location
    }
}
