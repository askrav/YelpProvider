//
//  CategoryTests.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 3/1/19.
//

import XCTest
@testable import Vapor
@testable import YelpProvider

class CategoryTests: XCTestCase {
    
    // MARK: CategoryModel
    
    private let categoryJSONString = """
{
    "alias": "category-alias",
    "title": "category-title",
    "parent_aliases": ["parent0", "parent1"],
    "country_whitelist": ["country0", "country1"],
    "country_blacklist": ["country2", "country3"]
}
"""
    
    func testCategoryParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970

            let body = HTTPBody(string: categoryJSONString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            
            let categoryFuture = try JSONDecoder().decode(CategoryModel.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            _ = categoryFuture.do { category in
                XCTAssertEqual(category.alias, "category-alias")
                XCTAssertEqual(category.title, "category-title")
                XCTAssertEqual(category.parentAliases, ["parent0", "parent1"])
                XCTAssertEqual(category.countryWhitelist, ["country0", "country1"])
                XCTAssertEqual(category.countryBlacklist, ["country2", "country3"])
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    // MARK: CategoryResponse
    
    private let categoryResponseJSONString = """
{
    "category": {
        "alias": "hotdogs",
        "title": "Fast Food",
        "parent_aliases": [
            "restaurants"
        ],
        "country_whitelist": [],
        "country_blacklist": []
    }
}
"""
    
    func testCategoryResponseParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: categoryResponseJSONString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            
            let categoryResponseFuture = try JSONDecoder().decode(CategoryResponse.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            _ = categoryResponseFuture.do { categoryResponse in
                let category = categoryResponse.category
                XCTAssertEqual(category.alias, "hotdogs")
                XCTAssertEqual(category.title, "Fast Food")
                XCTAssertEqual(category.parentAliases, ["restaurants"])
                XCTAssertEqual(category.countryWhitelist, [])
                XCTAssertEqual(category.countryBlacklist, [])
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    // MARK: CategoriesResponse
    
    private let categoriesResponseJSONString = """
{
    "categories": [
        {
            "alias": "active",
            "title": "Active Life",
            "parent_aliases": [],
            "country_whitelist": [],
            "country_blacklist": []
        },
        {
            "alias": "arts",
            "title": "Arts & Entertainment",
            "parent_aliases": [],
            "country_whitelist": [],
            "country_blacklist": []
        },
        {
            "alias": "auto",
            "title": "Automotive",
            "parent_aliases": [],
            "country_whitelist": [],
            "country_blacklist": []
        },
        {
            "alias": "beautysvc",
            "title": "Beauty & Spas",
            "parent_aliases": [],
            "country_whitelist": [],
            "country_blacklist": []
        },
        {
            "alias": "bicycles",
            "title": "Bicycles",
            "parent_aliases": [],
            "country_whitelist": [
                "CZ",
                "DK",
                "PL",
                "PT"
            ],
            "country_blacklist": []
        }
    ]
}
"""
    func testCategoriesResponseParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: categoriesResponseJSONString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            
            let categoriesResponseFuture = try JSONDecoder().decode(CategoriesResponse.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            _ = categoriesResponseFuture.do { categoriesResponse in
                let categories = categoriesResponse.categories
                XCTAssertEqual(categories.count, 5)
                
                let category = categories[4]
                
                XCTAssertEqual(category.alias, "bicycles")
                XCTAssertEqual(category.title, "Bicycles")
                XCTAssertEqual(category.parentAliases, [])
                XCTAssertEqual(category.countryWhitelist, ["CZ", "DK", "PL", "PT"])
                XCTAssertEqual(category.countryBlacklist, [])
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
}
