//
//  ButtonItem.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 7.02.22.
//

import Foundation
import UIKit

public struct ButtonItem: Decodable {
    public let text: Text
    public let route: String
    public let icon: Image?
    public let backgroundImage: Image?
    public let backgroundColor: Rgba?
    public let size: Size?
    public let cornerRadius: CGFloat?
}

extension ButtonItem: ItemProtocol {
    public func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        let button = UIButton(primaryAction: UIAction { _ in
            coordinator.navigate(to: route, params: params)
        })
        text.apply(to: button)
        var someImage = false
        if let icon = icon?.uiImage(params: params) {
            button.setImage(icon, for: .normal)
            someImage = true
        }
        if let backgroundImage = backgroundImage?.uiImage(params: params) {
            button.setBackgroundImage(backgroundImage, for: .normal)
            someImage = true
        }
        if someImage {
            button.setNeedsLayout()
            button.layoutIfNeeded()
            button.subviews.forEach { view in
                guard view is UIImageView else {
                    return
                }
                view.contentMode = .scaleAspectFill
                view.clipsToBounds = true
            }
        }
        button.backgroundColor = backgroundColor?.uiColor
        if let cornerRadius = cornerRadius {
            button.layer.cornerRadius = cornerRadius
        }
        size?.constraint(view: button, maxSize: maxSize)
        return button
    }
}
