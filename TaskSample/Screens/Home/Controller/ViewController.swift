//
//  ViewController.swift
//  TaskSample
//
//  Created by Praveen Reddy on 03/05/20.
//  Copyright © 2020 Praveen Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var tableView: UITableView = {
          let tableView = UITableView()
          tableView.tableFooterView = UIView()
          tableView.rowHeight = UITableView.automaticDimension
          tableView.estimatedRowHeight = 100
          tableView.translatesAutoresizingMaskIntoConstraints = false
          return tableView
      }()
      
      private lazy var refreshControl: UIRefreshControl = {
          let refreshControl = UIRefreshControl()
          refreshControl.addTarget(self, action:
                       #selector(handleRefresh(_:)),
                                   for: UIControl.Event.valueChanged)
          refreshControl.tintColor = UIColor.lightGray
          
          return refreshControl
      }()
      
      let viewModel = CountryViewModel()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          self.setupTableView()
          viewModel.fetchCountry {
              self.title = self.viewModel.titleForCountry()
              self.tableView.reloadData()
          }
      }
      
      fileprivate func setupTableView() {
          
          tableView.dataSource = self
          tableView.delegate = self
          tableView.register(AboutCountryCell.self, forCellReuseIdentifier: AboutCountryCell.reuseIdentifier)
          view.addSubview(tableView)
          tableView.addSubview(refreshControl)

          
          let views = ["view": view!, "tableView" : tableView]
          var allConstraints: [NSLayoutConstraint] = []
          allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: views as [String : Any])
          allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views as [String : Any])
          NSLayoutConstraint.activate(allConstraints)
      }
      
      @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
          viewModel.fetchCountry {
              self.title = self.viewModel.titleForCountry()
              self.tableView.reloadData()
              refreshControl.endRefreshing()
          }
      }
      
  }

  extension ViewController: UITableViewDataSource, UITableViewDelegate {
      
      func numberOfSections(in tableView: UITableView) -> Int {
          return viewModel.numberOfSections()
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return viewModel.numberOfRows()
      }
      
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: AboutCountryCell.reuseIdentifier, for: indexPath) as! AboutCountryCell
          cell.update(row: viewModel.rowForItemAtIndexPath(indexPath: indexPath))
          return cell
      }

}

