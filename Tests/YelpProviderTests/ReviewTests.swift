//
//  ReviewTests.swift
//  YelpProviderTests
//
//  Created by Alexander Kravchenko on 3/2/19.
//

import XCTest
@testable import Vapor
@testable import YelpProvider

class ReviewTests: XCTestCase {
    
    private let reviewJSONString = """
{
      "id": "xAG4O7l-t1ubbwVAlPnDKg",
      "rating": 5,
      "user": {
        "id": "W8UK02IDdRS2GL_66fuq6w",
        "profile_url": "https://www.yelp.com/user_details?userid=W8UK02IDdRS2GL_66fuq6w",
        "image_url": "https://s3-media3.fl.yelpcdn.com/photo/iwoAD12zkONZxJ94ChAaMg/o.jpg",
        "name": "Ella A."
      },
      "text": "Went back again to this place since the last time i visited the bay area 5 months ago, and nothing has changed. Still the sketchy Mission, Still the cashier...",
      "time_created": "2016-08-29 00:41:13",
      "url": "https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=hp8hAJ-AnlpqxCCu7kyCWA&adjust_creative=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w"
    }
"""
    func testReviewParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: reviewJSONString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            
            let reviewFuture = try JSONDecoder().decode(ReviewModel.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            _ = reviewFuture.do { review in
                XCTAssertEqual(review.id, "xAG4O7l-t1ubbwVAlPnDKg")
                XCTAssertEqual(review.rating, 5)
                XCTAssertEqual(review.text, "Went back again to this place since the last time i visited the bay area 5 months ago, and nothing has changed. Still the sketchy Mission, Still the cashier...")
                XCTAssertEqual(review.timeCreated, "2016-08-29 00:41:13")
                XCTAssertEqual(review.url, "https://www.yelp.com/biz/la-palma-mexicatessen-san-francisco?hrid=hp8hAJ-AnlpqxCCu7kyCWA&adjust_creative=0sidDfoTIHle5vvHEBvF0w&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=0sidDfoTIHle5vvHEBvF0w")
                
                XCTAssertEqual(review.user.id, "W8UK02IDdRS2GL_66fuq6w")
                XCTAssertEqual(review.user.profileUrl, "https://www.yelp.com/user_details?userid=W8UK02IDdRS2GL_66fuq6w")
                XCTAssertEqual(review.user.imageUrl, "https://s3-media3.fl.yelpcdn.com/photo/iwoAD12zkONZxJ94ChAaMg/o.jpg")
                XCTAssertEqual(review.user.name, "Ella A.")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
}
