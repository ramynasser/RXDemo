//
//  HistoryViewController.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import UIKit
import RxSwift
class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let disposeBag = DisposeBag()
    var viewModel: HistoryViewModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        guard let vm = viewModel else {
            return
        }
        bindToRx(viewModel: vm)
        
        // Do any additional setup after loading the view.
    }
    private func bindToRx(viewModel: HistoryViewModel) {
        viewModel
            .history?
            .bind(to: tableView
                .rx
                .items(cellIdentifier: HistoryCell.cellIdentifier, cellType: HistoryCell.self)) {row, viewModel, cell in
                    cell.configureCell(viewModel: viewModel)
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 64.0;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
