//
//  Provider.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/20/19.
//

import Vapor

public struct YelpConfig: Service {
    
    public let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
}

public final class YelpProvider: Provider {
    
    public func register(_ services: inout Services) throws {
        services.register { container -> YelpClient in
            let httpClient = try container.make(Client.self)
            let config = try container.make(YelpConfig.self)
            let apiKey = config.apiKey
            return YelpClient(apiKey: apiKey, client: httpClient)
        }
    }
    
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}

public final class YelpClient: Service {
    
    public var autocomplete: YelpAutocompleteRoutes
    public var business: YelpBusinessRoutes
    public var event: YelpEventRoutes
    public var categories: YelpCategoryRoutes
    
    init(apiKey: String, client: Client) {
        let apiRequest = YelpAPIRequest(httpClient: client, apiKey: apiKey)
        
        autocomplete = YelpAutocompleteRoutes(request: apiRequest)
        business = YelpBusinessRoutes(request: apiRequest)
        event = YelpEventRoutes(request: apiRequest)
        categories = YelpCategoryRoutes(request: apiRequest)
    }
}
