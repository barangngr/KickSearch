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
          let session = URLSession.shared
          let url = URL(string: "http://starlord.hackerearth.com/kickstarter")!
          let task = session.dataTask(with: url, completionHandler: { data, response, error in
              
              if error != nil {
                  completionHandler(false, nil)
                  return
              }
              
              do {
                  let json = try JSONDecoder().decode([MainResponse].self, from: data! )
                  completionHandler(true, json)
              } catch {
                  print("Error during JSON serialization: \(error.localizedDescription)")
                  completionHandler(false, nil)
              }
              
          })
          task.resume()
          
      }

}
