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
  var meeseCanadaInfo: CanadaInfo!
  var ehCanadaInfo: CanadaInfo!
  var spaceProgramCanadaInfo:CanadaInfo!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      meeseCanadaInfo = CanadaInfo(title: "Meese", description: "", imageUrlString: "http://carldeckerwildlifeartstudio.net/wp-content/uploads/2011/04/IMG_2418%20majestiv%20moose%201%20copy%20(small)-96x96,jpg")
      ehCanadaInfo = CanadaInfo(title: "Eh", description: "A chiefly canadian interrogative iutterance, usually expressing surprise or doubt or seeking confirmation", imageUrlString: "")
      spaceProgramCanadaInfo = CanadaInfo(title: "Housing", description: "", imageUrlString: "http://icons.iconarchive.com.icons/iconshock/alaska/256/Igloo-icon.png")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      
      super.tearDown()
      meeseCanadaInfo = nil
      ehCanadaInfo = nil
      spaceProgramCanadaInfo = nil
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
