//
//  HerbsGalleryModuleInterface.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import RxSwift

protocol HerbsGalleryModuleInterface {
    func displayHerbs()
    func didSelectItemAtIndex(index: Int)
    func displayDetailedInfoForActiveItem()
    var itemsSequence: Observable<[HerbsAndHealthProblemWrapper]> {get}
    var isEmpty: Observable<Bool> {get}
}
