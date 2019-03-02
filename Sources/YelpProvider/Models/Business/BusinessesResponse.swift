//
//  BusinessResponse.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Foundation

public struct BusinessesResponse: YelpModel {
    
    public var total: Int
    public var businesses: [BusinessModel]
    public var region: BusinessesRegion?
    
    public enum CodingKeys: String, CodingKey {
        case total
        case businesses
        case region
    }
}

public struct BusinessesRegion: YelpModel {
    
    public var center: CoordinatesModel
    
    public enum CodingKeys: String, CodingKey {
        case center
    }
}
