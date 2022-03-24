//
//  Size.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 5.02.22.
//

import Foundation
import UIKit

public struct Size: Decodable {
    public let conformity: Bool?
    public let widthConstant: Bool?
    public let heightConstant: Bool?
    public let width: CGFloat?
    public let height: CGFloat?
}

extension Size {
    func uiWidth(maxSize: CGSize) -> CGFloat? {
        guard let width = width else {
            guard conformity ?? false, let height = uiHeight(maxSize: maxSize) else {
                return nil
            }
            return maxSize.width < height ? maxSize.width : height
        }
        return widthConstant ?? false ? width : (width * maxSize.width) / 100
    }
    func uiHeight(maxSize: CGSize) -> CGFloat? {
        guard let height = height else {
            guard conformity ?? false, let width = uiWidth(maxSize: maxSize) else {
                return nil
            }
            return maxSize.height < width ? maxSize.height : width
        }
        return heightConstant ?? false ? height : (height * maxSize.height) / 100
    }
    func maxUiSize(maxSize: CGSize) -> CGSize {
        CGSize(
            width: uiWidth(maxSize: maxSize) ?? maxSize.width,
            height: uiHeight(maxSize: maxSize) ?? maxSize.height
        )
    }
    
    func constraint(view: UIView, maxSize: CGSize) {
        if let uiWidth = uiWidth(maxSize: maxSize) {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: uiWidth).isActive = true
        }
        if let uiHeight = uiHeight(maxSize: maxSize) {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: uiHeight).isActive = true
        }
    }
}
