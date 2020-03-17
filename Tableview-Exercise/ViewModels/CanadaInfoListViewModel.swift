//
//  CanadaInfoListViewModel.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 17/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import Foundation

struct CanadaInfoListViewModel {
  
  var title: String = ""
  var canadaInfoViewModel: [CanadaInfoViewModel] = [CanadaInfoViewModel]()
}

extension CanadaInfoListViewModel {
  
  init(canadaInfoList: [CanadaInfoViewModel]) {
    
    self.canadaInfoViewModel = canadaInfoList
  }
}

struct CanadaInfoViewModel {
  
  var title: String
  var description: String
  var imageUrlString: String
}

extension CanadaInfoViewModel {
  
  init(canadaInfo: CanadaInfo) {
    
    self.title = canadaInfo.title
    self.description = canadaInfo.description
    self.imageUrlString = canadaInfo.imageUrlString
  }
}
