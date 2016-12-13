//
//  HerbsGalleryInteractorProtocols.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import RxSwift

//MARK: - HerbsGalleryInteractorProtocol
protocol HerbsGalleryInteractorProtocol {
    func getAllHerbs() -> HerbsAndHealthProblemWrapperSequence
}


