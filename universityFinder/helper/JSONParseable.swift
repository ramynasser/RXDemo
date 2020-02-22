//
//  JSONParseable.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

protocol JSONParseable {
    static func fromJSON(_: JSON) -> Self
}
