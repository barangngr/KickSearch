//
//  MainResponse.swift
//  KickSearch
//
//  Created by Baran on 16.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import Foundation

struct MainResponse: Codable {
    var sNo: Double
    var amtPledged: Double
    var blurb: String
    var by: String
    var country: String
    var currency: String
    var endTime: String
    var location: String
    var percentageFunded: Double
    var numBackers: String
    var state: String
    var title: String
    var type: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case sNo = "s.no"
        case amtPledged = "amt.pledged"
        case blurb
        case by
        case country
        case currency
        case endTime = "end.time"
        case location
        case percentageFunded = "percentage.funded"
        case numBackers = "num.backers"
        case state
        case title
        case type
        case url
    }
    
}
