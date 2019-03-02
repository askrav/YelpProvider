//
//  BusinessTests.swift
//  YelpProviderTests
//
//  Created by Alexander Kravchenko on 3/2/19.
//

import XCTest
@testable import Vapor
@testable import YelpProvider

class BusinessTests: XCTestCase {
    
    private let businessJSONString = """
{
  "id": "WavvLdfdP6g8aZTtbBQHTw",
  "alias": "gary-danko-san-francisco",
  "name": "Gary Danko",
  "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/CPc91bGzKBe95aM5edjhhQ/o.jpg",
  "is_claimed": true,
  "is_closed": false,
  "url": "https://www.yelp.com/biz/gary-danko-san-francisco?adjust_creative=wpr6gw4FnptTrk1CeT8POg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=wpr6gw4FnptTrk1CeT8POg",
  "phone": "+14157492060",
  "display_phone": "(415) 749-2060",
  "review_count": 5296,
  "categories": [
    {
      "alias": "newamerican",
      "title": "American (New)"
    },
    {
      "alias": "french",
      "title": "French"
    },
    {
      "alias": "wine_bars",
      "title": "Wine Bars"
    }
  ],
  "rating": 4.5,
  "location": {
    "address1": "800 N Point St",
    "address2": "",
    "address3": "",
    "city": "San Francisco",
    "zip_code": "94109",
    "country": "US",
    "state": "CA",
    "display_address": [
      "800 N Point St",
      "San Francisco, CA 94109"
    ],
    "cross_streets": ""
  },
  "coordinates": {
    "latitude": 37.80587,
    "longitude": -122.42058
  },
  "photos": [
    "https://s3-media2.fl.yelpcdn.com/bphoto/CPc91bGzKBe95aM5edjhhQ/o.jpg",
    "https://s3-media4.fl.yelpcdn.com/bphoto/FmXn6cYO1Mm03UNO5cbOqw/o.jpg",
    "https://s3-media4.fl.yelpcdn.com/bphoto/HZVDyYaghwPl2kVbvHuHjA/o.jpg"
  ],
  "price": "$$$$",
  "hours": [
    {
      "open": [
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 0
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 1
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 2
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 3
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 4
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 5
        },
        {
          "is_overnight": false,
          "start": "1730",
          "end": "2200",
          "day": 6
        }
      ],
      "hours_type": "REGULAR",
      "is_open_now": false
    }
  ],
  "transactions": [],
  "special_hours": [
    {
      "date": "2019-02-07",
      "is_closed": null,
      "start": "1600",
      "end": "2000",
      "is_overnight": false
    }
  ]
}
"""
    
    func testBusinessParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: businessJSONString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            
            let businessFuture = try JSONDecoder().decode(BusinessModel.self,
                                                       from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            _ = businessFuture.do { business in
                XCTAssertEqual(business.id, "WavvLdfdP6g8aZTtbBQHTw")
                XCTAssertEqual(business.alias, "gary-danko-san-francisco")
                XCTAssertEqual(business.name, "Gary Danko")
                XCTAssertEqual(business.imageUrl, "https://s3-media2.fl.yelpcdn.com/bphoto/CPc91bGzKBe95aM5edjhhQ/o.jpg")
                XCTAssertEqual(business.isClaimed, true)
                XCTAssertEqual(business.isClosed, false)
                XCTAssertEqual(business.url, "https://www.yelp.com/biz/gary-danko-san-francisco?adjust_creative=wpr6gw4FnptTrk1CeT8POg&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=wpr6gw4FnptTrk1CeT8POg")
                XCTAssertEqual(business.phone, "+14157492060")
                XCTAssertEqual(business.displayPhone, "(415) 749-2060")
                XCTAssertEqual(business.reviewCount, 5296)
                XCTAssertEqual(business.rating, 4.5)
                XCTAssertEqual(business.categories?.count, 3)
                
                let category = business.categories![0]
                XCTAssertEqual(category.alias, "newamerican")
                XCTAssertEqual(category.title, "American (New)")
                
                XCTAssertEqual(business.location.address1, "800 N Point St")
                XCTAssertEqual(business.location.address2, "")
                XCTAssertEqual(business.location.address3, "")
                XCTAssertEqual(business.location.city, "San Francisco")
                XCTAssertEqual(business.location.zipCode, "94109")
                XCTAssertEqual(business.location.country, "US")
                XCTAssertEqual(business.location.state, "CA")
                XCTAssertEqual(business.location.displayAddress, [
                    "800 N Point St",
                    "San Francisco, CA 94109"
                    ])
                XCTAssertEqual(business.location.crossStreets, "")
                
                XCTAssertEqual(business.coordinates.longitude, -122.42058)
                XCTAssertEqual(business.coordinates.latitude, 37.80587)
                
                XCTAssertEqual(business.photos, [
                    "https://s3-media2.fl.yelpcdn.com/bphoto/CPc91bGzKBe95aM5edjhhQ/o.jpg",
                    "https://s3-media4.fl.yelpcdn.com/bphoto/FmXn6cYO1Mm03UNO5cbOqw/o.jpg",
                    "https://s3-media4.fl.yelpcdn.com/bphoto/HZVDyYaghwPl2kVbvHuHjA/o.jpg"
                    ])
                
                XCTAssertEqual(business.price, "$$$$")
                
                XCTAssertEqual(business.hours?.count, 1)
                let hour = business.hours![0]
                
                XCTAssertEqual(hour.open.count, 7)
                let open = hour.open[0]
                
                XCTAssertEqual(open.isOvernight, false)
                XCTAssertEqual(open.start, "1730")
                XCTAssertEqual(open.end, "2200")
                XCTAssertEqual(open.day, 0)
                
                XCTAssertEqual(business.transactions?.count, 0)
                
                XCTAssertEqual(business.specialHours?.count, 1)
                let specialHour = business.specialHours![0]
                
                XCTAssertEqual(specialHour.date, "2019-02-07")
                XCTAssertEqual(specialHour.isClosed, nil)
                XCTAssertEqual(specialHour.start, "1600")
                XCTAssertEqual(specialHour.end, "2000")
                XCTAssertEqual(specialHour.isOvernight, false)
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
}
