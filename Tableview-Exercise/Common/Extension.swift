//
//  Extension.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 17/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
  
  func loadImageWithCache(for urlString: String) {
    
    DispatchQueue.main.async {
      self.image = UIImage(named: "defaultImage")
    }
    
    guard let url = URL(string: urlString) else { return }
    
    if let cachedImage = imageCache.object(forKey: urlString as AnyObject) {
      DispatchQueue.main.async {
        self.image = cachedImage as? UIImage
      }
      return
    }
    
    URLSession.shared.dataTask(with: url) { (data, jsonResponse, error) in
      if error != nil {
        print(error?.localizedDescription as Any)
        return
      }
      
      guard let data = data else { return }
      
      if let image = UIImage(data: data) {
        
        DispatchQueue.main.async {
          imageCache.setObject(image, forKey: urlString as AnyObject)
          self.image = image
        }
      }
    }.resume()
  }
  
  func rounded(withBorder: Bool) {
    
    self.clipsToBounds = true
    self.layer.cornerRadius = Constants.height/2
    if (withBorder) {
      self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
      self.layer.borderWidth = 1.0
    } else {
      self.layer.borderWidth = 0.0
    }
  }
}
