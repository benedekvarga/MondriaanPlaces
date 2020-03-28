//
//  CAGradientLayer+Exts.swift
//
//  Created by Benedek Varga on 2020. 03. 26..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

public enum GradientOrientation {
    case none
    case bottomLeftTopRight
    case topLeftBottomRight
    case horizontal
    case vertical

    var startPoint: CGPoint {
        return points.startPoint
    }

    var endPoint: CGPoint {
        return points.endPoint
    }

    var points: GradientPoints {
        switch self {
        case .none:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 0.0, y: 0.0))
        case .bottomLeftTopRight:
            return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1.0, y: 1.0))
        case .horizontal:
            return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5, y: 1.0))
        }
    }
}

extension CAGradientLayer {
    public convenience init(withColors colors: [UIColor], gradientOrientation orientation: GradientOrientation) {
        self.init()
        self.colors = colors.map { $0.cgColor }
        startPoint = orientation.startPoint
        endPoint = orientation.endPoint
    }

    public func setColors(_ colors: [CGColor]) {
        self.colors = colors
    }
}
