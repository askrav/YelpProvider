//
//  EventsResponse.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/24/19.
//

import Foundation

public enum EventSortBy: String {
    case ascending = "asc"
    case descending = "desc"
}

public enum EventSortOn: String {
    case popularity
    case timeStart = "time_start"
}

public struct EventsResponse: YelpModel {
    
    public var events: [EventModel]
    public var total: Int
    
    public enum CodingKeys: String, CodingKey {
        case events
        case total
    }
}
