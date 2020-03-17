//
//  CanadaDetailsAPICalls.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 16/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import UIKit

class CanadaDetailsAPICalls: NSObject {
  
  static let sharedInstance = CanadaDetailsAPICalls()
  
  func getCanadaInfo(completionHandler: @escaping (NSMutableDictionary) -> ()) {
    //Setting up URL Request
    //BaseURL - https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json
    var canadaInfoArray = [CanadaInfo]()
    let canadaJsonDictionary = NSMutableDictionary()
    guard let url = URL(string: Constants.baseUrl) else {
      return
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    //Setting up URLSession
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    //Make request
    session.dataTask(with: urlRequest) { (data, response, error) in
      guard let data = data else { return }
      
      guard let dataString = String(data: data, encoding: .isoLatin1) else { return }
      
      guard let jsonData = dataString.data(using: .utf8) else { return }
      
      do {
        if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary {
          
          if let canadaInfoList = json["rows"] as? [NSDictionary] {
            canadaInfoArray = canadaInfoList.compactMap { dict in
              return CanadaInfo(dictionary: dict)
            }
            canadaJsonDictionary.setValue(canadaInfoArray, forKey: "canadaList")
          }
          if let canadaInfoTitle = json["title"] as? String {
            canadaJsonDictionary.setValue(canadaInfoTitle, forKey: "canadaTitle")
          }
        }
        
        DispatchQueue.main.async {
          completionHandler(canadaJsonDictionary)
        }
        
      } catch {
        print(error.localizedDescription)
        return
      }
    }.resume()
  }
}
