//
//  Text.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 6.02.22.
//

import Foundation
import UIKit

public struct Text: Decodable {
    public let value: String
    public let color: Rgba?
    public let size: CGFloat?
    public let textAlignment: TextAlignment?
}

extension Text {
    func apply(to button: UIButton) {
        button.setTitle(value, for: .normal)
        button.contentHorizontalAlignment = textAlignment?.contentVariant ?? .center
        apply(to: button.titleLabel!)
    }
    
    func apply(to label: UILabel) {
        label.text = value
        if let size = size {
            label.font = .systemFont(ofSize: size)
        }
        if let color = color {
            label.tintColor = color.uiColor
        }
        label.textAlignment = textAlignment?.nsVariant ?? .center
    }
}
