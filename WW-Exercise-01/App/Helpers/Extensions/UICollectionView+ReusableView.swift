//
//  UICollectionView+ReusableView.swift
//  WW-Exercise-01
//
//  Created by Aylwing Olivas on 1/16/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import UIKit

public protocol ReusableView: class { }

extension ReusableView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableView { }

public protocol NibLoadable: class { }

extension NibLoadable {

    public static var nibName: String {
        return String(describing: self)
    }

    public static func loadFromNib(owner: Any? = nil, in bundle: Bundle? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self {
        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: owner, options: options).first as! Self
    }
}

extension UICollectionView {

    public func register<T: UICollectionViewCell>(_ cell: T.Type, bundle: Bundle? = nil) where T: NibLoadable {
        register(UINib(nibName: T.nibName, bundle: bundle), forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    public func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            preconditionFailure("Cell is not properly reusable")
        }
        return cell
    }
}
