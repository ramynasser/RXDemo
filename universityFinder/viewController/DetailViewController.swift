//
//  DetailViewController.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import UIKit
import RxSwift
class DetailViewController: UIViewController {
    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryStars: UILabel!
    @IBOutlet weak var repositoryForks: UILabel!
    
    @IBOutlet weak var repositoryDescription: UILabel!
    
    @IBOutlet weak var repositoryLanguage: UILabel!
    @IBOutlet weak var repositoryHomepage: UILabel!
    
    @IBOutlet weak var repositoryCreated: UILabel!
    @IBOutlet weak var repositoryUpdated: UILabel!
    
    var viewModel: DetailViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let vm = viewModel else { return }
        
        self.repositoryName.text = vm.repositoryName
        self.repositoryDescription.text = vm.repositoryDescription
        self.repositoryStars.text = vm.repositoryStars
        self.repositoryForks.text = vm.repositoryForks
        self.repositoryLanguage.text = vm.repositoryLanguage
        self.repositoryHomepage.text = vm.repositoryHomepage
        self.repositoryCreated.text = vm.repositoryCreated
        self.repositoryUpdated.text = vm.repositoryUpdated
        
        vm.repositoryImage
            .bind(to: self.repositoryImageView.rx.image)
            .disposed(by: disposeBag)
    }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


