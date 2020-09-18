//
//  Requests.swift
//  KickSearch
//
//  Created by Baran on 16.09.2020.
//  Copyright © 2020 Baran. All rights reserved.
//

import Foundation

class Request {
    
    static let shared = Request()
    
    func getData(_ completionHandler: @escaping(_ isSuccess: Bool, _ data: [MainResponse]?) -> Void){
        
        guard let url = URL(string: "http://starlord.hackerearth.com/kickstarter") else { return }
        
        let session = URLSession.shared
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let data = cache.cachedResponse(for: request)?.data {
            
            let json = try? JSONDecoder().decode([MainResponse].self, from: data)
            completionHandler(true, json)
            
        } else {
            session.dataTask(with: url, completionHandler: { data, response, error in
    
                if error != nil {
                    completionHandler(false, nil)
                    return
                }
                
                // Look Here After!
                do {
                    if let response = response, let data = data {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        let json = try JSONDecoder().decode([MainResponse].self, from: data)
                        completionHandler(true, json)
                    }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                    completionHandler(false, nil)
                }
            })
                .resume()
        }
    }
    
}
