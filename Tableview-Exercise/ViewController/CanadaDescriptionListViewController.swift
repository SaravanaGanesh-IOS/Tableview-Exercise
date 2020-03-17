//
//  ViewController.swift
//  Tableview-Exercise
//
//  Created by Patric Phinehas Raj on 16/03/20.
//  Copyright © 2020 Saravana. All rights reserved.
//

import UIKit
import Reachability

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
  
  //View life cycle
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    self.getCanadaInfoViewModel()
    //Setting up the table view
    self.tableViewCreation()
    self.navigationBarSetup()
    // Do any additional setup after loading the view.
  }
  
  //Activity aindicator alert view creation
  func activityIndicatorAlert() {
    let alert = UIAlertController(title: nil, message: "Loading data...", preferredStyle: .alert)
    if #available(iOS 13.0, *) {
      activityIndicatorView.style = .medium
    } else {
      activityIndicatorView.style = .gray
    }
    activityIndicatorView.startAnimating()
    alert.view.addSubview(activityIndicatorView)
    self.present(alert, animated: true, completion: nil)
  }
  
  //Pull to refresh
  @objc
  func handlePullToRefresh() {
    DispatchQueue.main.async {
      self.tblViewDescriptionList.reloadData()
      self.refreshControl.endRefreshing()
    }
  }
  
  func removeDataSourceAsNoNetwork() {
    self.tblViewDescriptionList.dataSource = nil
    self.tblViewDescriptionList.delegate = nil
    self.tblViewDescriptionList.isHidden = true
    
    let labelNoNetwork = UILabel()
    self.view.backgroundColor = .white
    self.view.addSubview(labelNoNetwork)
    
    labelNoNetwork.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
    labelNoNetwork.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    labelNoNetwork.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    labelNoNetwork.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    labelNoNetwork.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    labelNoNetwork.text = "No network available please check your internet connection and try again"
    
    labelNoNetwork.translatesAutoresizingMaskIntoConstraints = false
    
    labelNoNetwork.textColor = .black
    labelNoNetwork.numberOfLines = 0
    labelNoNetwork.lineBreakMode = .byWordWrapping
    labelNoNetwork.font = UIFont.preferredFont(forTextStyle: .body)
    labelNoNetwork.textAlignment = .center
  }
  
  //Building view model for table view
  func getCanadaInfoViewModel() {
    activityIndicatorAlert()
    if (self.checkForReachability()) {
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
    } else {
      DispatchQueue.main.async {
        self.dismiss(animated: true, completion: nil)
      }
      self.removeDataSourceAsNoNetwork()
    }
  }
  
  func navigationBarSetup() {
    
    self.navigationController?.navigationBar.backgroundColor = .white
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  //Refresh control for table view
  func addRefreshControl() {
    
    refreshControl.sizeToFit()
    
    self.tblViewDescriptionList.refreshControl = refreshControl
  }
  
  func tableViewCreation() {
    
    self.view.addSubview(self.tblViewDescriptionList)
    
    self.tblViewDescriptionList.separatorInset = .zero
    self.tblViewDescriptionList.accessibilityIdentifier = "tableView--canadaInfoTableView"
    
    self.tblViewDescriptionList.delegate = self
    self.tblViewDescriptionList.dataSource = self
    self.tblViewDescriptionList.estimatedRowHeight = 80
    
    self.addRefreshControl()
    
    self.tblViewDescriptionList.translatesAutoresizingMaskIntoConstraints = false
    self.tblViewDescriptionList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    self.tblViewDescriptionList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    self.tblViewDescriptionList.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    self.tblViewDescriptionList.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    
    //Register cell for the tableview
    self.tblViewDescriptionList.register(CanadaDetailsTableViewCell.self, forCellReuseIdentifier: kReuseCellId)
  }
  
  //Deinitilizing view controller
  deinit {
    print("CanadaDescription deinit")
  }
}

//MARK - UITableViewDatasource, Delegate functions
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

