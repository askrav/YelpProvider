//
//  EventRoutes.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/24/19.
//

import Vapor

public protocol EventRoutes {
    func lookupEvent(id: String, locale: String?) throws -> Future<EventModel>
    
    func searchEvents(limit: Int, offset: Int, sortBy: EventSortBy?, sortOn: EventSortOn?, startDate: Int?,
                      endDate: Int?, categories: [Int]?, isFree: Bool?, location: String?, latitude: Double?,
                      longitude: Double?, radius: Int?, excludedEvents: [String]?) throws -> Future<EventsResponse>
    
    func featuredEvent(location: String?, latitude: Double?,
                       longitude: Double?, locale: String?) throws -> Future<EventModel>
}

extension EventRoutes {
    
    public func lookupEvent(id: String, locale: String? = nil) throws -> Future<EventModel> {
        return try lookupEvent(id: id, locale: locale)
    }
    
    public func searchEvents(limit: Int = 100, offset: Int = 0, sortBy: EventSortBy? = nil,
                             sortOn: EventSortOn? = nil, startDate: Int? = nil, endDate: Int? = nil,
                             categories: [Int]? = nil, isFree: Bool? = nil, location: String? = nil,
                             latitude: Double? = nil, longitude: Double? = nil, radius: Int? = nil,
                             excludedEvents: [String]? = nil) throws -> Future<EventsResponse> {
        return try searchEvents(limit: limit, offset: offset, sortBy: sortBy, sortOn: sortOn, startDate: startDate,
                                endDate: endDate, categories: categories, isFree: isFree, location: location,
                                latitude: latitude, longitude: longitude, radius: radius,
                                excludedEvents: excludedEvents)
    }
    
    public func featuredEvent(location: String? = nil, latitude: Double? = nil,
                              longitude: Double? = nil, locale: String? = nil) throws -> Future<EventModel> {
        return try featuredEvent(location: location, latitude: latitude, longitude: longitude, locale: locale)
    }
}

public struct YelpEventRoutes: EventRoutes {
    private let request: YelpRequest
    
    init(request: YelpRequest) {
        self.request = request
    }
    
    public func lookupEvent(id: String, locale: String?) throws -> EventLoopFuture<EventModel> {
        
        var paramsDict: [String: Any] = [:]
        if let locale = locale { paramsDict["locale"] = locale }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.lookupEvent(id).endpoint, query: params)
    }
    
    public func searchEvents(limit: Int, offset: Int, sortBy: EventSortBy?, sortOn: EventSortOn?, startDate: Int?, endDate: Int?, categories: [Int]?, isFree: Bool?, location: String?, latitude: Double?, longitude: Double?, radius: Int?, excludedEvents: [String]?) throws -> EventLoopFuture<EventsResponse> {
        
        var paramsDict: [String: Any] = ["limit": limit, "offset": offset]
        
        if let sortBy = sortBy { paramsDict["sort_by"] = sortBy.rawValue }
        if let sortOn = sortOn { paramsDict["sort_on"] = sortOn.rawValue }
        if let startDate = startDate { paramsDict["start_date"] = startDate }
        if let endDate = endDate { paramsDict["end_date"] = endDate }
        if let location = location { paramsDict["location"] = location }
        if let latitude = latitude { paramsDict["latitude"] = latitude }
        if let longitude = longitude { paramsDict["longitude"] = longitude }
        if let radius = radius { paramsDict["radius"] = radius }
        if let excludedEvents = excludedEvents { paramsDict["excluded_events"] = excludedEvents }
        if let categories = categories {
            var categoriesString = categories.reduce("", { $0 + "\($1)," })
            _ = categoriesString.removeLast()
            paramsDict["categories"] = categoriesString
        }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.searchEvents.endpoint, query: params)
    }
    
    public func featuredEvent(location: String?, latitude: Double?, longitude: Double?, locale: String?) throws -> EventLoopFuture<EventModel> {
        
        var paramsDict: [String: Any] = [:]
        if let location = location { paramsDict["location"] = location }
        if let latitude = latitude { paramsDict["latitude"] = latitude }
        if let longitude = longitude { paramsDict["longitude"] = longitude }
        if let locale = locale { paramsDict["locale"] = locale }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.featuredEvent.endpoint, query: params)
    }
}

