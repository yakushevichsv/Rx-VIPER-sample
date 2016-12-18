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

//MARK: - UIView display subview 
extension UIView {
    private func addOrBringToFront(view: UIView) {
        if view.superview != self {
            view.removeFromSuperview()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        if view.superview == nil {
            addSubview(view)
        }
        else {
            bringSubview(toFront: view)
        }
    }
    
    private func activate(constraints: [NSLayoutConstraint]) {
        constraints.forEach{ $0.isActive = true }
    }
    
    func addSubviewWithConstraints(view: UIView, top topConstant:CGFloat = 0, bottom bottomConstant: CGFloat = 0, left leftConstant: CGFloat = 0, right rightConstant: CGFloat = 0) {
        
        addOrBringToFront(view: view)
        
        let top = view.topAnchor.constraint(equalTo: topAnchor, constant: topConstant)
        let bottom = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant)
        let left = view.leftAnchor.constraint(equalTo: leftAnchor, constant: leftConstant)
        let right = view.rightAnchor.constraint(equalTo: rightAnchor, constant: rightConstant)
        activate(constraints: [top,bottom, left,right])
    }
    
    func addSubviewAtCenter(view: UIView) {
        addOrBringToFront(view: view)
        
        let centerX = view.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        let centerY = view.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        activate(constraints:[centerY,centerX])
    }
}


