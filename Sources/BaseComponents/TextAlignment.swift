//
//  TextAlignment.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 7.02.22.
//

import Foundation
import UIKit

public enum TextAlignment: Decodable {
    case left
    case center
    case right
}

extension TextAlignment {
    var nsVariant: NSTextAlignment {
        switch self {
        case .left:
            return .left
        case .center:
            return .center
        case .right:
            return .right
        }
    }
    var contentVariant: UIControl.ContentHorizontalAlignment {
        switch self {
        case .left:
            return .left
        case .center:
            return .center
        case .right:
            return .right
        }
    }
}
