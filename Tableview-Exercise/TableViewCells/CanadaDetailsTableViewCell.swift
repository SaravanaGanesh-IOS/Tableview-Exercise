//
//  CanadaDetailsTableViewCell.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 16/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import UIKit

class CanadaDetailsTableViewCell: UITableViewCell {
  
  var canadaInfo: CanadaInfo? {
    
    didSet {
      
      self.lblDescription.text = canadaInfo?.description
      self.lblTitle.text = canadaInfo?.title
      
      DispatchQueue.global(qos: .background).async { [weak self] in
        guard let self = self else { return }
        if let imageUrlString = self.canadaInfo?.imageUrlString {
          self.imgViewCanadaIcon.loadImageWithCache(for: imageUrlString)
        }
      }
      
      if self.lblTitle.text == nil || self.lblDescription.text == nil {

        self.imgViewCanadaIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.padding).isActive = true
        self.imgViewCanadaIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.padding).isActive = true
        self.imgViewCanadaIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = false
      } else {

        self.imgViewCanadaIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.padding).isActive = false
        self.imgViewCanadaIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.padding).isActive = false
        self.imgViewCanadaIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      }
    }
  }
  
  private var imgViewCanadaIcon: UIImageView = {
    
    let imgViewIcon = UIImageView()
    imgViewIcon.contentMode = .scaleToFill
    imgViewIcon.translatesAutoresizingMaskIntoConstraints = false
    imgViewIcon.image = UIImage(named: "defaultImage")
    
    return imgViewIcon
  }()
  
  private var lblTitle: UILabel = {
    
    let lblTitle = UILabel()
    lblTitle.numberOfLines = 0
    lblTitle.font = UIFont.preferredFont(forTextStyle: .headline)
    lblTitle.lineBreakMode = .byWordWrapping
    lblTitle.translatesAutoresizingMaskIntoConstraints = false
    
    return lblTitle
  }()
  
  private var lblDescription: UILabel = {
    
    let lblDescription = UILabel()
    lblDescription.numberOfLines = 0
    lblDescription.font = UIFont.preferredFont(forTextStyle: .footnote)
    lblDescription.lineBreakMode = .byWordWrapping
    lblDescription.translatesAutoresizingMaskIntoConstraints = false
    
    return lblDescription
  }()
  
  //Initilizing UITableViewCells
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(self.lblTitle)
    addSubview(self.lblDescription)
    addSubview(self.imgViewCanadaIcon)
    self.selectionStyle = .none
    
    self.lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.padding).isActive = true
    self.lblTitle.leadingAnchor.constraint(equalTo: self.imgViewCanadaIcon.trailingAnchor, constant: Constants.padding).isActive = true
    self.lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.padding).isActive = true
    self.lblTitle.bottomAnchor.constraint(equalTo: self.lblDescription.topAnchor, constant: -Constants.padding).isActive = true
    self.lblTitle.setContentHuggingPriority(.defaultHigh, for: .vertical)
    
    self.lblDescription.leadingAnchor.constraint(equalTo: self.imgViewCanadaIcon.trailingAnchor, constant: Constants.padding).isActive = true
    self.lblDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.padding).isActive = true
    self.lblDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.padding).isActive = true

    self.imgViewCanadaIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.padding).isActive = true
    self.imgViewCanadaIcon.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
    
    self.imgViewCanadaIcon.addConstraint(NSLayoutConstraint(item: self.imgViewCanadaIcon, attribute: .height, relatedBy: .equal, toItem: self.imgViewCanadaIcon, attribute: .width, multiplier: (1.0 / 1.0), constant: 0))
    
    self.imgViewCanadaIcon.rounded(withBorder: true)
  }
  
  required init?(coder: NSCoder) {
    
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    
    super.prepareForReuse()
    
    self.imgViewCanadaIcon.image = UIImage(named: "defaultImage")
    self.lblTitle.text = nil
    self.lblDescription.text = nil
  }
  
}
