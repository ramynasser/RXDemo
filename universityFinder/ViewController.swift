//
//  ViewController.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SafariServices

class ViewController: UIViewController {
    private let tableView = UITableView()
    private let cellIdentifier = "cellIdentifier"
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for university"
        return searchController
    }()
    
    private func configureProperties() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.searchController = searchController
        navigationItem.title = "University finder"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureProperties()
        configureLayout()
        configureReactiveBinding()
      
       
        

        // Do any additional setup after loading the view.
    }
    func isValid(observables: Observable<Bool>...) -> Observable<Bool> {
        let distinctObservables = observables.map {
            $0.distinctUntilChanged()
        }
        
        let observable = Observable.combineLatest(distinctObservables) { values -> Bool in
            var result = false 
            values.forEach({ (value) in
                result = result && value
            })
            return result
        }
        return observable
    }
    
    private func configureReactiveBinding() {
      searchController.searchBar.rx.text.asObservable()
        .map{($0 ?? "").lowercased()}
        .map{UniversityRequest(name: $0)}
        .flatMap { request -> Observable<[UniversityModel]> in
            return self.apiClient.send(apiRequest: request)
        }
        .bind(to: tableView.rx.items(cellIdentifier:cellIdentifier)) { index , model, cell in
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.description
            cell.textLabel?.adjustsFontSizeToFitWidth = true
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(UniversityModel.self)
        .map{URL(string: $0.webPages?.first ?? "")!}
            .map{SFSafariViewController(url: $0)}
            .subscribe(onNext: { [weak self] safariViewController in
                self?.present(safariViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }

}

