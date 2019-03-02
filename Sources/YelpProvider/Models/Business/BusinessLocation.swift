//
//  BusinessLocation.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Foundation

public struct BusinessLocation: YelpModel {
    
    public var address1: String
    public var address2: String?
    public var address3: String?
    
    public var city: String
    public var country: String
    public var state: String
    public var zipCode: String
    
    public var displayAddress: [String]
    public var crossStreets: String?
    
    public enum CodingKeys: String, CodingKey {
        case address1
        case address2
        case address3
        case city
        case country
        case state
        case zipCode = "zip_code"
        case displayAddress = "display_address"
        case crossStreets = "cross_streets"
    }
}
