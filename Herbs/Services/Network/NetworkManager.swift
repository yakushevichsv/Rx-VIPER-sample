//
//  NetworkManager.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import Moya
import Moya_ModelMapper
import RxOptional
import RxSwift

//MARK: - NetworkProtocol
protocol NetworkProtocol {
    typealias OptHerbArraySequence = Observable<[HerbsAndHealthProblem]?>
    func accessAllHerbs() -> OptHerbArraySequence
    
    func cancelOperation(sequence: OptHerbArraySequence)
}


//MARK: - NetworkManager
final class NetworkManager {
    let provider = RxMoyaProvider<HerbsAPI>(endpointClosure: HerbsAPI.endpointClosure)
}

//MARK: NetworkProtocol's implementation
extension NetworkManager: NetworkProtocol {
    func accessAllHerbs() -> NetworkProtocol.OptHerbArraySequence {
        return  provider.request(HerbsAPI.basicQuery).debug().mapArrayOptional(type: HerbsAndHealthProblem.self, keyPath: "results")
    }
    
    func cancelOperation(sequence: NetworkProtocol.OptHerbArraySequence) {
        if let dispose = sequence as? Disposable {
            dispose.dispose()
        }
    }
}
