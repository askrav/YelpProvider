//
//  AutocompleteRoutes.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Vapor

public protocol AutocompleteRoutes {
    func getInfo(text: String, latitude: Double?, longitude: Double?, locale: String?) throws -> Future<AutocompleteModel>
}

extension AutocompleteRoutes {
    public func getInfo(text: String, latitude: Double? = nil,
                        longitude: Double? = nil, locale: String? = nil) throws -> Future<AutocompleteModel> {
        return try getInfo(text: text, latitude: latitude, longitude: longitude, locale: locale)
    }
}

public struct YelpAutocompleteRoutes: 
AutocompleteRoutes {
    private let request: YelpRequest
    
    init(request: YelpRequest) {
        self.request = request
    }
    
    public func getInfo(text: String, latitude: Double?,
                        longitude: Double?, locale: String?) throws -> EventLoopFuture<AutocompleteModel> {
        
        var paramsDict: [String: Any] = ["text": text]
        if let lat = latitude { paramsDict["latitude"] = lat }
        if let long = longitude { paramsDict["longitiude"] = long }
        if let loc = locale { paramsDict["locale"] = loc }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.autocomplete.endpoint, query: params)
    }
}
