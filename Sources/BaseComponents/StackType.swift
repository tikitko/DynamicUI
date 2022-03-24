//
//  StackType.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 6.02.22.
//

import Foundation
import UIKit

public enum LayoutType: String, Decodable {
    case horizontal
    case vertical
}

extension LayoutType {
    var axis: NSLayoutConstraint.Axis {
        switch self {
        case .horizontal:
            return .horizontal
        case .vertical:
            return .vertical
        }
    }
    
    func maxSize(from originMaxSize: CGSize, spacing: CGFloat) -> CGSize {
        switch self {
        case .horizontal:
            return CGSize(width: originMaxSize.width - spacing, height: originMaxSize.height)
        case .vertical:
            return CGSize(width: originMaxSize.width, height: originMaxSize.height - spacing)
        }
    }
}
