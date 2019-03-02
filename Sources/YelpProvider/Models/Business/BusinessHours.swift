//
//  BusinessHours.swift
//  YelpProvider
//
//  Created by Alexander Kravchenko on 2/23/19.
//

import Foundation

public struct BusinessHours: YelpModel {

    public var open: [WorkDayInfo]
    public var hoursType: String
    public var openNow: Bool
    
    public enum CodingKeys: String, CodingKey {
        case open
        case hoursType = "hours_type"
        case openNow = "is_open_now"
    }
}

public struct BusinessSpecialHour: YelpModel {
    
    public var date: String
    public var isClosed: Bool?
    public var start: String
    public var end: String
    public var isOvernight: Bool
    
    public enum CodingKeys: String, CodingKey {
        case date
        case isClosed = "is_closed"
        case start
        case end
        case isOvernight = "is_overnight"
    }
}

public struct WorkDayInfo: YelpModel {
    
    public var isOvernight: Bool
    public var start: String
    public var end: String
    public var day: Int
    
    public enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start
        case end
        case day
    }
}
