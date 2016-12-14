//
//  HerbsGalleryWireframe.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/13/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit
//MARK: - HerbsGalleryWireframeProtocol
protocol HerbsGalleryWireframeProtocol {
    func presentInWindowOnNeed(window: UIWindow)
    func prepareToDisplayItem(item: HerbDetailsViewProtocol, herbWrapper: HerbsAndHealthProblemWrapper)
}

//MARK: - HerbsGalleryWireframe
final class HerbsGalleryWireframe {
    let network: NetworkProtocol
    let imageAccessor: ImageAccesorProtocol
    
    init(network: NetworkProtocol, imageAccessor: ImageAccesorProtocol) {
        self.network = network
        self.imageAccessor = imageAccessor
    }
}

//MARK: - HerbsGalleryWireframeProtocol's implementation
extension HerbsGalleryWireframe: HerbsGalleryWireframeProtocol {
    
    func presentInWindowOnNeed(window: UIWindow) {
        let interactor = HerbsGalleryInteractor(network: network, imageAccessor: imageAccessor)
        
        assert(window.rootViewController is HerbsGalleryViewController)
        let herbsVC = window.rootViewController as! HerbsGalleryViewController
        
        let presenter: HerbsGalleryModuleInterface = HerbsGalleryPresenter(interactor: interactor,wireframe: self,  view: herbsVC) as HerbsGalleryModuleInterface
        
        herbsVC.presenter = presenter
    }
    
    func prepareToDisplayItem(item: HerbDetailsViewProtocol, herbWrapper: HerbsAndHealthProblemWrapper) {
        guard let dView = item as? HerbDetailsViewController else {
            assert(false)
            return
        }
        
        let wireframe = HerbDetailsWireframe(network: network, imageAccessor: imageAccessor)
        wireframe.define(view: dView, herbWrapper: herbWrapper)
        
    }
}
