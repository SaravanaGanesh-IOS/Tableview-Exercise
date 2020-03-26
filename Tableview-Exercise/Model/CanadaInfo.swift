//
//  CanadaInfo.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 16/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import Foundation

struct CanadaInfo: Codable {
  
  let title: String?
  let description: String?
  var imageUrlString: String?

  private enum CodingKeys: String, CodingKey {
    case title = "title"
    case description = "description"
    case imageUrlString = "imageHref"
  }
  
  /// Initilizing with title, description, imageUrlString for model class
  /// - Parameters:
  ///   - title: "Canada"
  ///   - description: "canada is the one of the best countries"
  ///   - imageUrlString: "http://12213ewqe3.jpg"
  
  init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: CodingKeys.self)
    title = try value.decodeIfPresent(String.self, forKey: .title)
    description = try value.decodeIfPresent(String.self, forKey: .description)
    imageUrlString = try value.decodeIfPresent(String.self, forKey: .imageUrlString)
  }
  
  init(title: String?, description: String?, imageUrlString: String?) {
    self.title = title
    self.description = description
    self.imageUrlString = imageUrlString
  }
}

struct CanadaInfoDataSource: Codable {
  let title: String?
  let rows: [CanadaInfo]?
  
  private enum DataSourceCodingKeys: String, CodingKey {
    case title = "title"
    case rows = "rows"
  }
  
  init(from decoder: Decoder) throws {
    let value = try decoder.container(keyedBy: DataSourceCodingKeys.self)
    title = try value.decodeIfPresent(String.self, forKey: .title)
    rows = try value.decodeIfPresent([CanadaInfo].self, forKey: .rows)
  }
}







