//
//  String.swift
//  KickSearch
//
//  Created by Baran on 16.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import Foundation

extension String {
    
    func toDate() -> Date?{
        if #available(iOS 10.0, *) {
            let dateFormatter = ISO8601DateFormatter()
            return dateFormatter.date(from: self)
        } else {
            // Fallback on earlier versions
        }
        return DateFormatter().date(from: self)
    }
    
}
