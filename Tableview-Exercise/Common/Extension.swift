//
//  Extension.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 17/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import Foundation
import UIKit
import Reachability

//Initilizing cache for images
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
  
  /// loading image from url and adding image to NSCache and loading it to image view in the cell
  /// - Parameter urlString: urlString - "http://1239f9euf.jpg"
  func loadImageWithCache(for urlString: String) {
    
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.image = UIImage(named: "defaultImage")
    }
    
    guard let url = URL(string: urlString) else { return }
    
    if let cachedImage = imageCache.object(forKey: urlString as AnyObject) {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
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
        
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          imageCache.setObject(image, forKey: urlString as AnyObject)
          self.image = image
        }
      }
    }.resume()
  }
  
  
  /// Imageview rounded
  /// - Parameter withBorder: withBorder - Bool
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

extension UIViewController {
  
  /// Check for network reachability of device
  func checkForReachability() -> Bool {
    var isReachable = false
    let reachablity = try? Reachability()
    
    if reachablity?.connection == .wifi {
      isReachable = true
    } else if reachablity?.connection == .cellular {
      isReachable = true
    } else {
      isReachable = false
    }
    
    do {
      try reachablity?.startNotifier()
    } catch {
      print("Error while start notify for reachability")
    }
    return isReachable
  }
}
