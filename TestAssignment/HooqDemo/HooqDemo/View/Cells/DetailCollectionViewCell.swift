//
//  DetailCollectionViewCell.swift
//  HooqDemo
//
//  Created by Kajal on 3/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import UIKit

final class DetailCollectionViewCell: UICollectionViewCell {    
    @IBOutlet private weak var imageView: CustomImageView!

    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func setupCellData(_ value : MovieList?)  {
        guard let poster = value?.path else {
            imageView.image = UIImage(named:GlobalConstants.noImage)
            return
        }
        
        DispatchQueue.main.async {
            self.imageView.loadImageUsingUrlString(GlobalConstants.homeImageURL + poster)
        }
    }
}
