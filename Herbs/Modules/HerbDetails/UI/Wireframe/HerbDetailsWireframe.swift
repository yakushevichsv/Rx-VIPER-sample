//
//  HerbDetailsWireframe.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/13/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit

//MARK: - HerbDetailsWireframeProtocol
protocol HerbDetailsWireframeProtocol {
    func define(view vc: HerbDetailsViewController, herbWrapper: HerbsAndHealthProblemWrapper)
}

//MARK: - HerbDetailsWireframe
final class HerbDetailsWireframe {
    let network: NetworkProtocol
    let imageAccessor: ImageAccesorProtocol
    let transitioner = DetailsTransitioner()
    
    init(network: NetworkProtocol, imageAccessor: ImageAccesorProtocol, frame: CGRect) {
        self.network = network
        self.imageAccessor = imageAccessor
        self.transitioner.originFrame = frame
    }
}

//MARK: - HerbDetailsWireframeProtocol's implementation
extension HerbDetailsWireframe: HerbDetailsWireframeProtocol {
    func define(view vc: HerbDetailsViewController, herbWrapper: HerbsAndHealthProblemWrapper) {
        let interactor = HerbDetailsInteractor(network: network,imageAccessor: imageAccessor)
        let presenter = HerbDetailsPresenter(interactor: interactor, wireframe: self, view: vc)
        presenter.wrapper = herbWrapper
        vc.presenter = presenter
        transitioner.initialBlock = {
            presenter.hideLabels()
        }
        transitioner.completionBlock = {
            presenter.displayLabels()
        }
       vc.transitioningDelegate = transitioner
        vc.modalPresentationStyle = .custom
    }
}
