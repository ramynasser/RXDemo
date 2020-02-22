//
//  ObservableConvertibleType+Void.swift
//  universityFinder
//
//  Created by Ramy Nasser on 10/1/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableConvertibleType where E == Void {
    
    func asDriver() -> Driver<E> {
        return self.asDriver(onErrorJustReturn: Void())
    }
    
}
