//
//  Protocol.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/15/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit

//MARK: - NetworkUICommuncationProtocol
protocol UICommuncationProtocol: class {
    func dismiss()
    func present(error: Error)
    func hideLoadingProgress()
    func displayLoadingProgress()
}

//MARK: - NetworkUICommuncationProtocol for UIViewController
extension UICommuncationProtocol  where Self: UIViewController {
    func present(error: Error) {
        present(error: error,animated: true, completion:nil)
    }
    func dismiss() {
        _ = dismissIfPresented()
    }
}
