//
//  ReusableView.swift
//
//  Created by Benedek Varga on 04/06 F 96.
//  Copyright © 2018. Koin Finances Kft. All rights reserved.
//

import UIKit

// If a UIView is a ReusableView, then have a reuseIdentifier
protocol ReusableView {}
extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// Extend reusable views
extension UITableViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}
