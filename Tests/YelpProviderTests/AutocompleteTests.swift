//
//  AutocompleteTests.swift
//  YelpProviderTests
//
//  Created by Alexander Kravchenko on 3/2/19.
//

import XCTest
@testable import Vapor
@testable import YelpProvider

class AutocompleteTests: XCTestCase {
    
    private let autocompleteJSONString = """
{
  "terms": [
    {
      "text": "Delivery"
    }
  ],
  "businesses": [
    {
      "name": "Delfina",
      "id": "YqvoyaNvtoC8N5dA8pD2JA"
    },
    {
      "text": "Delarosa",
      "id": "vu6PlPyKptsT6oEq50qOzA"
    },
    {
      "text": "Pizzeria Delfina",
      "id": "bai6umLcCNy9cXql0Js2RQ"
    }
  ],
  "categories": [
    {
      "alias": "delis",
      "title": "Delis"
    },
    {
      "alias": "fooddeliveryservices",
      "title": "Food Delivery Services"
    },
    {
      "alias": "couriers",
      "title": "Couriers & Delivery Services"
    }
  ]
}
"""
    
    func testAutocompleteParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: autocompleteJSONString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            
            let autocompleteFuture = try JSONDecoder().decode(AutocompleteModel.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            _ = autocompleteFuture.do { autocomplete in
                XCTAssertEqual(autocomplete.terms.count, 1)
                XCTAssertEqual(autocomplete.terms[0].text, "Delivery")
                
                XCTAssertEqual(autocomplete.businesses.count, 3)
                XCTAssertEqual(autocomplete.businesses[0].id, "YqvoyaNvtoC8N5dA8pD2JA")
                XCTAssertEqual(autocomplete.businesses[0].name, "Delfina")
                XCTAssertEqual(autocomplete.businesses[0].text, nil)
                XCTAssertEqual(autocomplete.businesses[1].name, nil)
                XCTAssertEqual(autocomplete.businesses[1].text, "Delarosa")
                
                XCTAssertEqual(autocomplete.categories.count, 3)
                XCTAssertEqual(autocomplete.categories[0].alias, "delis")
                XCTAssertEqual(autocomplete.categories[0].title, "Delis")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
}
