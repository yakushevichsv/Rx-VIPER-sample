//
//  AppAssembly.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/13/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit

final class AppAssembly {
    let network: NetworkProtocol = NetworkManager()
    let accessor: ImageAccesorProtocol = ImageAccessor()
    
    func configureRootViewController(fromWindow window: UIWindow) {
        
        let wireFrame = HerbsGalleryWireframe(network: network, imageAccessor: accessor)
        
        wireFrame.presentInWindowOnNeed(window: window)
    }
}
