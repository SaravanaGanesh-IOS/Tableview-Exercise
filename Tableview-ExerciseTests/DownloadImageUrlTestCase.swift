//
//  DownloadImageUrlTestCase.swift
//  Tableview-ExerciseTests
//
//  Created by Patric Phinehas Raj on 17/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import XCTest
@testable import Tableview_Exercise

class DownloadImageUrlTestCase: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    checkForImage()
  }
  
  func checkForImage() {
    guard let url = URL(string: "http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg") else { return }
    XCTAssertTrue(url != nil)
    
    URLSession.shared.dataTask(with: url) { (data, jsonResponse, error) in
      if error != nil {
        print(error?.localizedDescription as Any)
        return
      }
      
      guard let data = data else { return }
      
      if let image = UIImage(data: data) {
        XCTAssertTrue(image != nil)
      }
    }.resume()
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
