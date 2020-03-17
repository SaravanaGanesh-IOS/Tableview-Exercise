//
//  ViewController.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 16/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import UIKit

class CanadaDescriptionListViewController: UIViewController {
  let tblViewDescriptionList = UITableView()
  let kReuseCellId = "canadaCellId"
  
  private var canadaInfoViewModel: CanadaInfoListViewModel = CanadaInfoListViewModel() {
    
    didSet {
      
      DispatchQueue.main.async {
        self.tblViewDescriptionList.reloadData()
      }
    }
  }
  
  private lazy var activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    activityIndicator.color = .gray
    return activityIndicator
  }()
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = .gray
    refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
    return refreshControl
  }()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    //Setting up the table view
    self.getCanadaInfoViewModel()
    self.tableViewCreation()
    self.navigationBarSetup()
    // Do any additional setup after loading the view.
  }
  
  func activityIndicatorAlert() {
    let alert = UIAlertController(title: nil, message: "Loading data...", preferredStyle: .alert)
    activityIndicatorView.style = .medium
    activityIndicatorView.startAnimating()
    alert.view.addSubview(activityIndicatorView)
    self.present(alert, animated: true, completion: nil)
  }
  
  @objc
  func handlePullToRefresh() {
    DispatchQueue.main.async {
      self.tblViewDescriptionList.reloadData()
      self.refreshControl.endRefreshing()
    }
  }
  
  func getCanadaInfoViewModel() {
    activityIndicatorAlert()
    DispatchQueue.global(qos: .default).async {
      
      CanadaDetailsAPICalls.sharedInstance.getCanadaInfo { (jsonDict) in
        
        DispatchQueue.main.async {
          if let title = jsonDict.value(forKey: "canadaTitle") as? String {
            self.navigationItem.title = title
          }
        }
        
        if let canadaInfoListJson = jsonDict.value(forKey: "canadaList") as? [CanadaInfo] {
          let canadaInfoList = canadaInfoListJson.compactMap { canadaInfo in
            return CanadaInfoViewModel(canadaInfo: canadaInfo)
          }
          
          self.canadaInfoViewModel = CanadaInfoListViewModel(canadaInfoList: canadaInfoList)
          DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
          }
        }
      }
    }
  }
  
  func navigationBarSetup() {
    
    self.navigationController?.navigationBar.backgroundColor = .white
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func addRefreshControl() {
    
    refreshControl.sizeToFit()
    
    self.tblViewDescriptionList.refreshControl = refreshControl
  }
  
  func tableViewCreation() {
    
    self.view.addSubview(self.tblViewDescriptionList)
    
    self.tblViewDescriptionList.delegate = self
    self.tblViewDescriptionList.dataSource = self
    
    self.addRefreshControl()
    
    self.tblViewDescriptionList.translatesAutoresizingMaskIntoConstraints = false
    self.tblViewDescriptionList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    self.tblViewDescriptionList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    self.tblViewDescriptionList.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    self.tblViewDescriptionList.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    
    //Register cell for the tableview
    self.tblViewDescriptionList.register(CanadaDetailsTableViewCell.self, forCellReuseIdentifier: kReuseCellId)
  }
}

extension CanadaDescriptionListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return canadaInfoViewModel.canadaInfoViewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let canadaDetailCell = tableView.dequeueReusableCell(withIdentifier: kReuseCellId) as? CanadaDetailsTableViewCell {
      let canadaInfoModel = self.canadaInfoViewModel.canadaInfoViewModel[indexPath.row]
      canadaDetailCell.canadaInfo = canadaInfoModel
      return canadaDetailCell
    }
    return UITableViewCell()
  }
}

