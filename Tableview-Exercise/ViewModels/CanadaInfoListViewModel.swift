//
//  CanadaInfoListViewModel.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 17/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import Foundation

class CanadaInfoListViewModel {
  
  var title: String = ""
  var rows: [CanadaInfo] = [CanadaInfo]()
  
  init(model: CanadaInfoDataSource? = nil) {
    if model != nil {
      if let title = model?.title {
        self.title = title
      }
      if let rows = model?.rows {
        self.rows = rows
      }
    }
  }
}

extension CanadaInfoListViewModel {
  func fetchCanadaDetailData(completionHandler: @escaping(Result<CanadaInfoDataSource, Error>) -> Void) {
    CanadaDetailsAPICalls.sharedInstance.getCanadaInfo(completionHandler: { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .failure(let error):
        print("failure", error)
        break
      case .success(let data):
        do {
          let decoder = JSONDecoder()
          let canadaInfoModel = try decoder.decode(CanadaInfoDataSource.self, from: data)
          if let title = canadaInfoModel.title {
            self.title = title
          }
          if let rows = canadaInfoModel.rows {
            self.rows = rows
          }
          completionHandler(.success(try decoder.decode(CanadaInfoDataSource.self, from: data)))
        } catch {
          
        }
        break
      }
    })
  }
}
