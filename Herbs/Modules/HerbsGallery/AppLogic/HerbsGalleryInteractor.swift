//
//  HerbsGalleryInteractor.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

//MARK: - HerbsGalleryInteractor
final class HerbsGalleryInteractor {
    let network: NetworkProtocol
    let imagesAccessor: ImageAccesorProtocol
    init(network: NetworkProtocol, imageAccessor accessor: ImageAccesorProtocol) {
        self.network = network
        self.imagesAccessor = accessor
    }
}

//MARK: - HerbsGalleryInteractorInput
extension HerbsGalleryInteractor: HerbsGalleryInteractorProtocol {
    func getAllHerbs() -> HerbsAndHealthProblemWrapperSequence {
        let result = network.accessAllHerbs()
        
        return result.filterNil().flatMap { (items) -> HerbsAndHealthProblemWrapperSequence in
            
            let wrappers = items.map{ self.imagesAccessor.receiveImage(herbPtr: $0) }
            
            let result = Observable<HerbsAndHealthProblemWrapper>.concat(wrappers)
            
            
            return result
        }
    
    }
}
