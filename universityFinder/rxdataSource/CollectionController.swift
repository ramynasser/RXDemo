//
//  CollectionController.swift
//  universityFinder
//
//  Created by Ramy Nasser on 12/2/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import UIKit
struct ViewModel {
    let items = [
        TargetSection(header: "First section", items: [
            Target(name: "1.0"),
            Target(name:"2.0"),
            Target(name:"3.0")
            ]),
        TargetSection(header: "Second section", items: [
            Target(name:"1.0"),
            Target(name:"2.0"),
            Target(name:"3.0")
            ]),
        TargetSection(header: "Third section", items: [
            Target(name:"1.0"),
            Target(name:"2.0"),
            Target(name:"3.0")
            ])
        ]

}

class CollectionController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    let disposeBag = DisposeBag()
    var viewModel = ViewModel()
    lazy var dataSource: RxCollectionViewSectionedReloadDataSource<TargetSection> = {
        let dataSource = RxCollectionViewSectionedReloadDataSource<TargetSection>(configureCell: { (_, collection, indexPath, target) -> UICollectionViewCell in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            return cell
        })
        return dataSource
    }()
  

    private func registerHeaderCell() {
        let nib = UINib(nibName: "CellHeader2", bundle: nil)
        collection.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CellHeader2")
       
        let nibe = UINib(nibName: "FooterView", bundle: nil)
        collection.register(nibe, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")

    }
    private func registerCollectionViewCell() {
        let nib = UINib(nibName:"CollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    private func setupLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height:60)
        layout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height:50)
        collection.setCollectionViewLayout(layout, animated: false)
    }
    private func bindViewModelToCollectionView(){
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CellHeader2", for: indexPath) as! CellHeader2
            case UICollectionView.elementKindSectionFooter:
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView", for: indexPath) as! FooterView
                
            default:
                return UICollectionReusableView()
            }
       
        }
        collection.rx.setDelegate(self).disposed(by: disposeBag)
//
        dataSource.configureCell = {(datasource, collectionView, indexPath, itemViewModel) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            return cell
        }
        
//        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
//            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView", for: indexPath) as! FooterView
//            footer.backgroundColor = .blue
//            return footer
//        }
        
        Observable.just(viewModel.items)
            .bind(to: collection.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
//
//        viewModel.items
//            .bind(to: collection.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerHeaderCell()
        registerCollectionViewCell()
        setupLayout()
        bindViewModelToCollectionView()

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

}

extension CollectionController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = collectionView.frame.size
        return CGSize(width: (viewSize.width - 30) / 2, height: (viewSize.width - 30) / 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let viewWidth = collectionView.frame.size.width
        return CGSize(width: viewWidth, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let viewWidth = collectionView.frame.size.width
        return CGSize(width: viewWidth, height: 50)
    }
}
