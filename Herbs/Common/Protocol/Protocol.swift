//
//  Protocol.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/15/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit
import Moya

//MARK: - NetworkUICommuncationProtocol
protocol UICommuncationProtocol: class {
    func dismiss()
    func present(error: Swift.Error)
    func hideLoadingProgress()
    func displayLoadingProgress()
}

//MARK: - NetworkUICommuncationProtocol for UIViewController
extension UICommuncationProtocol  where Self: UIViewController {
    func present(error: Swift.Error) {
        var fError = error
        if let mError = error as? Moya.Error {
            switch mError {
            case .underlying(let uError):
                fError = uError
                break
            default:
                break
            }
        }
        
        if fError.isNetworkIssue {
            present(title: "Error", message: NSLocalizedString("Can't access remote computer", comment: ""))
        }
        else {
            present(error: fError,animated: true, completion:nil)
        }
    }
    func dismiss() {
        _ = dismissIfPresented()
    }
}
