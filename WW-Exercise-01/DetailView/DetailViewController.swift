//
//  DetailViewController.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/27/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!

    var foodItem: FoodListItem

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    init(foodItem: FoodListItem) {
        self.foodItem = foodItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        title = foodItem.title
        imageView.sd_setImage(with: Endpoint.image(foodItem.image).url, placeholderImage: #imageLiteral(resourceName: "Placeholder-image"), options: .retryFailed)
    }
}
