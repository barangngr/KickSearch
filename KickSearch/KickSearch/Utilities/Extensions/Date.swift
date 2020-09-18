//
//  Date+.swift
//  KickSearch
//
//  Created by Baran on 16.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import Foundation

extension Date{
    
    func toString(format : String) -> String {
        let formatter =  DateFormatter()
        formatter.locale = Locale.init(identifier: Locale.preferredLanguages.first!)
        formatter.dateFormat = format
        let value = formatter.string(from: self)
        return value
    }
    
}
