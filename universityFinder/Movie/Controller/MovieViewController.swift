//
//  ViewController.swift
//  InstabugTask
//
//  Created by Ramy Nasser on 2/19/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import UIKit

class MovieViewController: BaseVC {
    // MARK: - Outlets Variable
    
    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var noDataLabl: UILabel!
    
    // MARK: - Instance Variable
    
    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    // MARK: - view Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_: Bool) {

    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
       // navigationController?.navigationBar.setStyle(style: .solidNoShadow)
        title = "Movies"
        //showBackButton()
    }
    
    override func setupTableView() {
        super.setupTableView()
//        movieTableView.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier)
          movieTableView.estimatedRowHeight = 50
          movieTableView.rowHeight = UITableView.automaticDimension
          movieTableView.tableFooterView = UIView()
        if #available(iOS 10.0, *) {
          movieTableView.refreshControl = self.refreshControl
          movieTableView.refreshControl?.tintColor = UIColor.black
        } else {
          movieTableView.addSubview(refreshControl)
        }
    }
    
   
    @IBAction func goToAddMovie(_: Any) {
    }
}

// MARK: - Movie Presenter Protocol

extension MovieViewController {
    func addNoDataView() {
        noDataView.isHidden = false
        noDataLabl.text = "No Movies"
    }
    
    func showNoInternet() {
        noDataView.isHidden = false
        noDataLabl.text = "No Internet"
    }
    
    func refreshView() {
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
    }
}

// MARK: - TableView Delegate

