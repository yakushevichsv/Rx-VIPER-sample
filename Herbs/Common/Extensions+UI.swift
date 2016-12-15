//
//  Extensions+UI.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/14/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit

//MARK: - Data
extension Data {
    func toImage() -> UIImage?{
        return UIImage(data: self)
    }
}

//MARK: - UIView
extension UIView {
    struct Constants {
        static let activityIndicatorTag: Int = 354
    }

    func displayActivityIndicator() {
    
        var fView =  viewWithTag(Constants.activityIndicatorTag) as? UIActivityIndicatorView
        if fView == nil  {
            let aiView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            aiView.translatesAutoresizingMaskIntoConstraints = false
            aiView.hidesWhenStopped = true
            aiView.color = UIColor.darkText
            aiView.tag = Constants.activityIndicatorTag
            aiView.contentMode = .center
            addSubview(aiView)
            aiView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            aiView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            fView = aiView
        }
        
        fView?.superview?.bringSubview(toFront: fView!)
        fView?.isHidden = false
        fView?.startAnimating()
    }
    
    func hideActivityIndicator() {
        guard let fView =  viewWithTag(Constants.activityIndicatorTag) as? UIActivityIndicatorView else {
            return
        }
        fView.stopAnimating()
    }
}

//MARK: - UIViewController
extension UIViewController {
    func present(error: Error, animated: Bool = true, completion:(() -> Void)? = nil)  {
        present(title: "Error", message: error.localizedDescription, animated: animated, completion: completion)
    }
    
    func present(title: String , message: String, animated: Bool = true, completion:(() -> Void)? = nil)  {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {(_) in
            self.dismiss(animated: false, completion: nil)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func dismissIfPresented(animated: Bool = true, completion:(() -> Void)? = nil) -> Bool {
        if let pVC = presentingViewController {
            pVC.dismiss(animated: animated, completion: completion)
            return true
        }
        return false
    }
}

//MARK: - static functions
func displayActivityIndicator() {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    debugPrint(#function)
}

func hideActivityIndicator() {
    debugPrint(#function)
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
}


