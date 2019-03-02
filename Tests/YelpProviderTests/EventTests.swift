//
//  EventTests.swift
//  YelpProviderTests
//
//  Created by Alexander Kravchenko on 3/2/19.
//

import XCTest
@testable import Vapor
@testable import YelpProvider

class EventTests: XCTestCase {
    
    private let eventJSONString = """
{
  "attending_count": 6,
  "category": "food-and-drink",
  "cost": null,
  "cost_max": null,
  "description": "Saucy is throwing up a pop-up restaurant party over at Anfilo Coffee! Give the menu a little peruse and then register to reserve your spot! Prices are shown...",
  "event_site_url": "https://www.yelp.com/events/oakland-saucy-oakland-restaurant-pop-up?adjust_creative=bDRxc9t1hBa515Tva4s3rg&utm_campaign=yelp_api_v3&utm_medium=api_v3_event_lookup&utm_source=bDRxc9t1hBa515Tva4s3rg",
  "id": "oakland-saucy-oakland-restaurant-pop-up",
  "image_url": "https://s3-media2.fl.yelpcdn.com/ephoto/TZ0gQ1nSBVe_X4PYg44s0w/o.jpg",
  "interested_count": 18,
  "is_canceled": false,
  "is_free": false,
  "is_official": false,
  "latitude": 37.8112634,
  "longitude": -122.2659978,
  "name": "Saucy Oakland | Restaurant Pop-Up",
  "tickets_url": "https://www.eventbrite.com/e/saucy-oakland-restaurant-pop-up-tickets-36287157866?aff=es2#tickets",
  "time_end": "2017-08-19T04:00:00+00:00",
  "time_start": "2017-08-19T01:00:00+00:00",
  "location": {
    "address1": "35 Grand Ave",
    "address2": "",
    "address3": "",
    "city": "Oakland",
    "zip_code": "94612",
    "country": "US",
    "state": "CA",
    "display_address": [
      "35 Grand Ave",
      "Oakland, CA 94612"
    ],
    "cross_streets": "Broadway & Webster St"
  },
  "business_id": "anfilo-oakland-2"
}
"""
    
    func testEventParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: eventJSONString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            
            let eventFuture = try JSONDecoder().decode(EventModel.self,
                                                       from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            _ = eventFuture.do { event in
                XCTAssertEqual(event.attendingCount, 6)
                XCTAssertEqual(event.category, "food-and-drink")
                XCTAssertEqual(event.cost, nil)
                XCTAssertEqual(event.costMax, nil)
                XCTAssertEqual(event.description, "Saucy is throwing up a pop-up restaurant party over at Anfilo Coffee! Give the menu a little peruse and then register to reserve your spot! Prices are shown...")
                XCTAssertEqual(event.eventSiteUrl, "https://www.yelp.com/events/oakland-saucy-oakland-restaurant-pop-up?adjust_creative=bDRxc9t1hBa515Tva4s3rg&utm_campaign=yelp_api_v3&utm_medium=api_v3_event_lookup&utm_source=bDRxc9t1hBa515Tva4s3rg")
                XCTAssertEqual(event.id, "oakland-saucy-oakland-restaurant-pop-up")
                XCTAssertEqual(event.imageUrl, "https://s3-media2.fl.yelpcdn.com/ephoto/TZ0gQ1nSBVe_X4PYg44s0w/o.jpg")
                XCTAssertEqual(event.interestedCount, 18)
                XCTAssertEqual(event.isCanceled, false)
                XCTAssertEqual(event.isFree, false)
                XCTAssertEqual(event.isOfficial, false)
                XCTAssertEqual(event.latitude, 37.8112634)
                XCTAssertEqual(event.longitude, -122.2659978)
                XCTAssertEqual(event.name, "Saucy Oakland | Restaurant Pop-Up")
                XCTAssertEqual(event.ticketsUrl, "https://www.eventbrite.com/e/saucy-oakland-restaurant-pop-up-tickets-36287157866?aff=es2#tickets")
                XCTAssertEqual(event.timeEnd, "2017-08-19T04:00:00+00:00")
                XCTAssertEqual(event.timeStart, "2017-08-19T01:00:00+00:00")
                XCTAssertEqual(event.location.address1, "35 Grand Ave")
                XCTAssertEqual(event.location.address2, "")
                XCTAssertEqual(event.location.address3, "")
                XCTAssertEqual(event.location.city, "Oakland")
                XCTAssertEqual(event.location.zipCode, "94612")
                XCTAssertEqual(event.location.country, "US")
                XCTAssertEqual(event.location.state, "CA")
                XCTAssertEqual(event.location.displayAddress, [
                    "35 Grand Ave",
                    "Oakland, CA 94612"
                    ])
                XCTAssertEqual(event.location.crossStreets, "Broadway & Webster St")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
}
