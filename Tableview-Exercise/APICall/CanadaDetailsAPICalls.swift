//
//  CanadaDetailsAPICalls.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 16/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import UIKit

final class CanadaDetailsAPICalls: NSObject {
  
  static let sharedInstance = CanadaDetailsAPICalls()
  private override init() { }
  
  enum HTTPError: Error {
    case invalidUrl
    case invalidResponse(Data?, URLResponse?)
  }
  
  /// Getting get canada info details from the Url using URLSession
  /// BaseURL - https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json
  /// - Parameter completionHandler: returns Dictionary
  
  func getCanadaInfo(completionHandler: @escaping (Result<Data, Error>) -> Void) {
    //Setting up URL Request
    guard let url = URL(string: Constants.baseUrl) else {
      completionHandler(.failure(HTTPError.invalidUrl))
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
      guard error == nil else {
        completionHandler(.failure(error!))
        return
      }
      guard let data = data else { return }
      
      guard let dataString = String(data: data, encoding: .isoLatin1) else { return }
      
      guard let jsonData = dataString.data(using: .utf8),
        let httpResponse = response as? HTTPURLResponse,
        200 ..< 300 ~= httpResponse.statusCode else {
          completionHandler(.failure(HTTPError.invalidResponse(data, response)))
          return
      }
      
      DispatchQueue.main.async {
        completionHandler(.success(jsonData))
      }
    }.resume()
  }
}
