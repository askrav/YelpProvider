//
//  Endpoints.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/21/19.
//

import Foundation

fileprivate let baseURL = "https://api.yelp.com/"
fileprivate let APIVersion = "v3/"

enum YelpEndpoint {
    
    case autocomplete
    
    case searchBusiness
    case searchBusinessPhone
    case businessDetails(String)
    case searchBusinessMatches
    case businessReviews(String)
    case searchTransactions(String)
    
    case lookupEvent(String)
    case searchEvents
    case featuredEvent
    
    case categories
    case categoryDetails(String)
    
    var endpoint: String {
        switch self {
        case .autocomplete: return baseURL + APIVersion + "autocomplete"
            
        case .searchBusiness: return baseURL + APIVersion + "businesses/search"
        case .searchBusinessPhone: return baseURL + APIVersion + "businesses/search/phone"
        case .businessDetails(let id): return baseURL + APIVersion + "businesses/\(id)"
        case .searchBusinessMatches: return baseURL + APIVersion + "businesses/matches"
        case .businessReviews(let id): return baseURL + APIVersion + "businesses/\(id)/reviews"
        case .searchTransactions(let type): return baseURL + APIVersion + "transactions/\(type)/search"
            
        case .lookupEvent(let id): return baseURL + APIVersion + "events/\(id)"
        case .searchEvents: return baseURL + APIVersion + "events"
        case .featuredEvent: return baseURL + APIVersion + "events/featured"
            
        case .categories: return baseURL + APIVersion + "categories"
        case .categoryDetails(let alias): return baseURL + APIVersion + "categories/\(alias)"
        }
    }
}
