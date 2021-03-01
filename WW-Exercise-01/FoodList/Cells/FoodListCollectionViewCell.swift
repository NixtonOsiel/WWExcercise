//
//  FoodListCollectionViewCell.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import UIKit

final class FoodListCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var title: UILabel!

    var imageTapped: (() -> Void)? {
        didSet {
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(imageViewTapped)))
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @objc private func imageViewTapped() {
        imageTapped?()
    }
}
