//
//  CoordinatesModel.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Foundation

public struct CoordinatesModel: YelpModel {
    
    public var latitude: Double
    public var longitude: Double
    
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
