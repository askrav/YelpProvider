//
//  CategoryRoutes.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/24/19.
//

import Vapor

public protocol CategoryRoutes {
    
    func getCategories(locale: String?) throws -> Future<CategoriesResponse>
    
    func categoryDetails(alias: String, locale: String?) throws -> Future<CategoryResponse>
}

extension CategoryRoutes {
    
    public func getCategories(locale: String? = nil) throws -> Future<CategoriesResponse> {
        return try getCategories(locale: locale)
    }
    
    public func categoryDetails(alias: String, locale: String? = nil) throws -> Future<CategoryResponse> {
        return try categoryDetails(alias: alias, locale: locale)
    }
}

public struct YelpCategoryRoutes: CategoryRoutes {
    private let request: YelpRequest
    
    init(request: YelpRequest) {
        self.request = request
    }
    
    public func getCategories(locale: String?) throws -> EventLoopFuture<CategoriesResponse> {
        
        var paramsDict: [String: Any] = [:]
        if let locale = locale { paramsDict["locale"] = locale }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.categories.endpoint, query: params)
    }
    
    public func categoryDetails(alias: String, locale: String?) throws -> EventLoopFuture<CategoryResponse> {
        
        var paramsDict: [String: Any] = ["alias": alias]
        if let locale = locale { paramsDict["locale"] = locale }
        
        let params = paramsDict.queryParameters
        return try request.send(method: .GET, path: YelpEndpoint.categoryDetails(alias).endpoint, query: params)
    }
}
