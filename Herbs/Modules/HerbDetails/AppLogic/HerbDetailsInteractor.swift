//
//  HerbDetailsInteractor.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

//MARK: - HerbDetailsInteractorProtocol
protocol HerbDetailsInteractorProtocol {
    func getHerbDetails(herbWrapper: HerbsAndHealthProblemWrapper) -> HerbsAndHealthProblemWrapperSequence
}

//MARK: - HerbDetailsInteractor
final class HerbDetailsInteractor {
    let network: NetworkProtocol
    let imagesAccessor: ImageAccesorProtocol
    
    init(network: NetworkProtocol, imageAccessor accessor: ImageAccesorProtocol) {
        self.network = network
        self.imagesAccessor = accessor
    }
}

//MARK: - HerbDetailsInteractorInput
extension HerbDetailsInteractor: HerbDetailsInteractorProtocol {
    func getHerbDetails(herbWrapper: HerbsAndHealthProblemWrapper) -> HerbsAndHealthProblemWrapperSequence {
        let result = network.accessHerb(herbType: herbWrapper.herb.objectId)
        
        return result.filterNil().flatMap { (item) -> HerbsAndHealthProblemWrapperSequence in
            
            if item == herbWrapper.herb {
                return  HerbsAndHealthProblemWrapperSequence.just(herbWrapper)
            }
            
            let wrapper = self.imagesAccessor.receiveImage(herbPtr: item)
            
            return wrapper
        }
    
    }
}
