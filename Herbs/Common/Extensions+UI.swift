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

//MARK: - UIViewController 
extension UIViewController {
    struct Constants {
        static let activityIndicatorTag: Int = 354
    }
    
}
