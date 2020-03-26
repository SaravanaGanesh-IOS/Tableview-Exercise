//
//  CanadaInfoTestCase.swift
//  Tableview-ExerciseTests
//
//  Created by Patric Phinehas Raj on 17/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import XCTest
@testable import Tableview_Exercise

class CanadaInfoTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class
      let json = """
                {
                  "title" : "country",
                  "description" : "india",
                  "imageHref" : "http://india.jpg"
                }
      """.data(using: .utf8)!
      
      let canadaInfoTest = try! JSONDecoder().decode(CanadaInfo.self, from: json)
      
      XCTAssertEqual(canadaInfoTest.title, "country")
  }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      
      super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
