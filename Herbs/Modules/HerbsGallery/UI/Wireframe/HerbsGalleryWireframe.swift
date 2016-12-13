//
//  HerbsGalleryWireframe.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/13/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit
//MARK: - HerbsGalleryWireframeProtocol
protocol HerbsGalleryWireframeProtocol { }

//MARK: - HerbsGalleryWireframe
final class HerbsGalleryWireframe {
    let network: NetworkProtocol
    let imageAccessor: ImageAccesorProtocol
    
    init(network: NetworkProtocol, imageAccessor: ImageAccesorProtocol) {
        self.network = network
        self.imageAccessor = imageAccessor
    }
    
    func presentInWindowOnNeed(window: UIWindow) {
        let interactor = HerbsGalleryInteractor(network: network, imageAccessor: imageAccessor)
        
        assert(window.rootViewController is HerbsGalleryViewController)
        let herbsVC = window.rootViewController as! HerbsGalleryViewController
        
        let presenter: HerbsGalleryModuleInterface = HerbsGalleryPresenter(interactor: interactor,wireframe: self,  view: herbsVC) as! HerbsGalleryModuleInterface
        
        herbsVC.presenter = presenter
    }
}

//MARK: - HerbsGalleryWireframeProtocol's implementation
extension HerbsGalleryWireframe: HerbsGalleryWireframeProtocol {}
