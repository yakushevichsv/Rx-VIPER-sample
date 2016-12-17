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

//MARK: - NetworkHerbProtocol
protocol NetworkHerbProtocol  {
    typealias OptHerbArraySequence = Observable<[HerbsAndHealthProblem]?>
    typealias OptHerbSequence = Observable<HerbsAndHealthProblem?>
    
    func accessAllHerbs() -> OptHerbArraySequence
    func accessHerb(herbType: HerbsAndHealthProblem.ObjectIdType) -> OptHerbSequence
}

//MARK: - NetworkGoogleSearchProtocol
protocol NetworkGoogleSearchProtocol {
    typealias OptImageSearchArraySequence = Observable<[GoogleSearchImage]?>
    func searchImages(query: String ,startNumber startIndex: Int, count : Int) -> OptImageSearchArraySequence
}

//MARK: - NetworkProtocol
protocol NetworkProtocol: NetworkHerbProtocol, NetworkGoogleSearchProtocol {}


//MARK: - NetworkManager
final class NetworkManager {
    let provider = RxMoyaProvider<HerbsAPI>(endpointClosure: HerbsAPI.endpointClosure)
    let googleProvier = RxMoyaProvider<GoogleImageAPI>(plugins: [ NetworkLoggerPlugin()])
}

//MARK: NetworkHerbProtocol's implementation
extension NetworkManager: NetworkHerbProtocol {
    internal func accessHerb(herbType: HerbsAndHealthProblem.ObjectIdType) -> NetworkProtocol.OptHerbSequence {
    
        return  provider.request(HerbsAPI.retrieve(herbType)).debug().mapObjectOptional(type: HerbsAndHealthProblem.self)
    }

    func accessAllHerbs() -> NetworkProtocol.OptHerbArraySequence {
        return  provider.request(HerbsAPI.basicQuery).debug().mapArrayOptional(type: HerbsAndHealthProblem.self, keyPath: "results")
    }
}

//MARK: - NetworkGoogleSearchProtocol
extension NetworkManager: NetworkGoogleSearchProtocol {
    func searchImages(query: String ,startNumber startIndex: Int = 1, count : Int = 10) -> NetworkProtocol.OptImageSearchArraySequence {
        assert(startIndex > 0)
        return googleProvier.request(GoogleImageAPI.image(query: query, startIndex: startIndex, count: count)).debug().mapArrayOptional(type: GoogleSearchImage.self, keyPath: "items")
    }
}

//MARK: - NetworkProtocol
extension NetworkManager: NetworkProtocol {}

