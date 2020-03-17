//
//  CanadaInfo.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 16/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import Foundation

class CanadaInfo {
  
  var title: String
  var description: String
  var imageUrlString: String
  
  
  /// Initilizing with title, description, imageUrlString for model class
  /// - Parameters:
  ///   - title: "Canada"
  ///   - description: "canada is the one of the best countries"
  ///   - imageUrlString: "http://12213ewqe3.jpg"
  init(title: String, description: String, imageUrlString: String) {
    self.title = title
    self.description = description
    self.imageUrlString = imageUrlString
  }
  
  init?(dictionary: NSDictionary) {
    
    self.title = ""
    self.description = ""
    self.imageUrlString = ""
    
    if let title = dictionary.value(forKey: "title") as? String {
      self.title = title
    }
    if let description = dictionary.value(forKey: "description") as? String {
      self.description = description
    }
    if let imageUrlString = dictionary.value(forKey: "imageHref") as? String {
      self.imageUrlString = imageUrlString
    }
  }
  
  deinit {
    print("Canada Info deinitialized")
  }
}
