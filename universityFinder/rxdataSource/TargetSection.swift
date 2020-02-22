//
//  TargetSection.swift
//  universityFinder
//
//  Created by Ramy Nasser on 12/2/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import RxDataSources
protocol AlbumCellViewModelType {
}
protocol PostCellViewModelType {

}


struct Target {
    var name: String
    var items:Either<AlbumCellViewModelType, PostCellViewModelType>
}
struct TargetSection {
    var header: String
    var items: [Target]
}
extension TargetSection: SectionModelType {
    typealias Item = Target
    init(original: TargetSection, items: [Item]) {
        self = original
        self.items = items
    }
}
