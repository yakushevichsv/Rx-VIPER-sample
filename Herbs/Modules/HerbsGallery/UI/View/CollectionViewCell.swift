//
//  CollectionViewCell.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/13/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ivHerb: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ivHerb.image = nil
    }
}
