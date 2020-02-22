//
//  HistoryCell.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastView: UILabel!
    
    static let cellIdentifier = "HistoryCell"
    
    private var disposeBag = DisposeBag()
    
    func configureCell(viewModel: HistoryCellViewModel) {
        name.text = viewModel.name
        lastView.text = viewModel.lastViewed
    }
    
}
