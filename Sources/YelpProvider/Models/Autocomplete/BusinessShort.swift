//
//  BusinessAutocomplete.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Foundation

public struct BusinessShort: YelpModel {
    
    public var id: String
    public var name: String?
    public var text: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case text
    }
}
