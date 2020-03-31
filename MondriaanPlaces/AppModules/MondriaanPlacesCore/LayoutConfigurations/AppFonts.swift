//
//  AppFonts.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit

extension UIFont {
    // MARK: - Objektiv Mk2

    class func rubikBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Bold", size: size)!
    }

    class func rubikItalic(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Italic", size: size)!
    }

    class func rubikRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-Regular", size: size)!
    }

    class var rubikBold: UIFont {
        return UIFont(name: "Rubik-Bold", size: 10)!
    }

    class var rubikItalic: UIFont {
        return UIFont(name: "Rubik-Italic", size: 10)!
    }

    class var rubikRegular: UIFont {
        return UIFont(name: "Rubik-Regular", size: 10)!
    }
}
