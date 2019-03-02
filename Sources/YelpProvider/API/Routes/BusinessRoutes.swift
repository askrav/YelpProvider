//
//  BusinessRoutes.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Vapor

public protocol BusinessRoutes {
    
    func search(term: String?, location: String?, latitude: Double?, longitude: Double?, radius: Int?,
                categories: String?, locale: String?, limit: Int?, sort_by: String?, price: String?,
                open_now: Bool?, attributes: String?) throws -> Future<BusinessesResponse>
    
    func searchPhone(phone: String) throws -> Future<BusinessesResponse>
    
    func searchTransactions(type: String, latitude: Double?,
                            longitude: Double?, location: String?) throws -> Future<BusinessesResponse>
    
    func searchBusinessMatches(name: String, address1: String, address2: String?, address3: String?,
                               city: String, state: String, country: String, latitude: Double?,
                               longitude: Double?, phone: String?, zipCode: String?, yelpBusinessId: String?,
                               limit: Int?, matchThreshold: String?) throws -> Future<Businesses>
    
    func businessDetails(id: String, locale: String?) throws -> Future<BusinessModel>
    
    func businessReviews(id: String, locale: String?) throws -> Future<ReviewResponse>
}

extension BusinessRoutes {
    
    public func search(term: String? = nil, location: String? = nil, latitude: Double? = nil,
                       longitude: Double? = nil, radius: Int? = nil, categories: String? = nil,
                       locale: String? = nil, limit: Int? = nil, sort_by: String? = nil, price: String? = nil,
                       open_now: Bool? = nil, attributes: String? = nil) throws -> Future<BusinessesResponse> {
        return try search(term: term, location: location, latitude: latitude, longitude: longitude,
                          radius: radius, categories: categories, locale: locale, limit: limit,
                          sort_by: sort_by, price: price, open_now: open_now, attributes: attributes)
    }
    
    public func searchPhone(phone: String) throws -> Future<BusinessesResponse> {
        return try searchPhone(phone: phone)
    }
    
    public func searchTransactions(type: String, latitude: Double? = nil, longitude: Double? = nil,
                                   location: String? = nil) throws -> Future<BusinessesResponse> {
        return try searchTransactions(type: type, latitude: latitude, longitude: longitude, location: location)
    }
    
    public func businessDetails(id: String, locale: String? = nil) throws -> Future<BusinessModel> {
        return try businessDetails(id: id, locale: locale)
    }
    
    public func searchBusinessMatches(name: String, address1: String, address2: String? = nil,
                                      address3: String? = nil, city: String, state: String, country: String,
                                      latitude: Double? = nil, longitude: Double? = nil, phone: String? = nil,
                                      zipCode: String? = nil, yelpBusinessId: String? = nil, limit: Int? = nil,
                                      matchThreshold: String? = nil) throws -> Future<Businesses> {
        return try searchBusinessMatches(name: name, address1: address1, address2: address2, address3: address3,
                                     city: city, state: state, country: country, latitude: latitude, longitude: longitude,
                                     phone: phone, zipCode: zipCode, yelpBusinessId: yelpBusinessId, limit: limit, matchThreshold: matchThreshold)
    }
    
    func businessReviews(id: String, locale: String? = nil) throws -> Future<ReviewResponse> {
        return try businessReviews(id: id, locale: locale)
    }
}

public struct YelpBusinessRoutes: BusinessRoutes {
    private let request: YelpRequest
    
    init(request: YelpRequest) {
        self.request = request
    }
    
    public func search(term: String?, location: String?, latitude: Double?, longitude: Double?, radius: Int?, 
                       categories: String?, locale: String?, limit: Int?, sort_by: String?, price: String?,
                       open_now: Bool?, attributes: String?) throws -> EventLoopFuture<BusinessesResponse> {
        
        var paramsDict: [String: Any] = [:]
        if let term = term { paramsDict["term"] = term }
        if let location = location { paramsDict["location"] = location }
        if let latitude = latitude { paramsDict["latitude"] = latitude }
        if let longitude = longitude { paramsDict["longitude"] = longitude }
        if let radius = radius { paramsDict["radius"] = radius }
        if let categories = categories { paramsDict["categories"] = categories }
        if let locale = locale { paramsDict["locale"] = locale }
        if let limit = limit { paramsDict["limit"] = limit }
        if let sort_by = sort_by { paramsDict["sort_by"] = sort_by }
        if let price = price { paramsDict["price"] = price }
        if let open_now = open_now { paramsDict["open_now"] = open_now }
        if let attributes = attributes { paramsDict["attributes"] = attributes }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.searchBusiness.endpoint, query: params)
    }
    
    public func searchPhone(phone: String) throws -> EventLoopFuture<BusinessesResponse> {
        let paramsDict: [String: Any] = ["phone": phone]
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.searchBusinessPhone.endpoint, query: params)
    }
    
    public func searchTransactions(type: String, latitude: Double?,
                                   longitude: Double?, location: String?) throws -> EventLoopFuture<BusinessesResponse> {
        
        var paramsDict: [String: Any] = [:]
        if let location = location { paramsDict["location"] = location }
        if let latitude = latitude { paramsDict["latitude"] = latitude }
        if let longitude = longitude { paramsDict["longitude"] = longitude }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.searchTransactions(type).endpoint, query: params)
    }
    
    public func businessDetails(id: String, locale: String?) throws -> EventLoopFuture<BusinessModel> {
        var paramsDict: [String: Any] = [:]
        if let locale = locale { paramsDict["locale"] = locale }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.businessDetails(id).endpoint, query: params)
    }
    
    public func searchBusinessMatches(name: String, address1: String, address2: String?, address3: String?, city: String,
                                      state: String, country: String, latitude: Double?, longitude: Double?, phone: String?,
                                      zipCode: String?, yelpBusinessId: String?, limit: Int?, matchThreshold: String?) throws -> EventLoopFuture<Businesses> {
        
        var paramsDict: [String: Any] = ["name": name, "address1": address1,
                                         "city": city, "state": state, "country": country]
        if let address2 = address2 { paramsDict["address2"] = address2 }
        if let address3 = address3 { paramsDict["address3"] = address3 }
        if let latitude = latitude { paramsDict["latitude"] = latitude }
        if let longitude = longitude { paramsDict["longitude"] = longitude }
        if let phone = phone { paramsDict["phone"] = phone }
        if let zipCode = zipCode { paramsDict["zip_code"] = zipCode }
        if let yelpBusinessId = yelpBusinessId { paramsDict["yelp_business_id"] = yelpBusinessId }
        if let limit = limit { paramsDict["limit"] = limit }
        if let matchThreshold = matchThreshold { paramsDict["match_threshold"] = matchThreshold }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.searchBusinessMatches.endpoint, query: params)
    }
    
    public func businessReviews(id: String, locale: String?) throws -> EventLoopFuture<ReviewResponse> {
        var paramsDict: [String: Any] = [:]
        if let locale = locale { paramsDict["locale"] = locale }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.businessReviews(id).endpoint, query: params)
    }
}

