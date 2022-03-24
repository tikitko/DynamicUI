//
//  StackItem.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 7.02.22.
//

import Foundation
import UIKit

public struct StackItem<I>: Decodable where I: CustomItemProtocol, I: Decodable {
    public let type: LayoutType
    public let size: Size?
    public let spacing: CGFloat?
    public let items: [Item<I>]
}

extension StackItem: ItemProtocol {
    public func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        let inSize = size?.maxUiSize(maxSize: maxSize) ?? maxSize
        let usefulInSize = spacing.map { type.maxSize(from: inSize, spacing: $0 * CGFloat(items.count - 1) ) } ?? inSize
        let views = items.map { $0.buildView(params: params, coordinator: coordinator, maxSize: usefulInSize) }
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = type.axis
        stack.alignment = .fill
        stack.distribution = .fill
        if let spacing = spacing {
            stack.spacing = spacing
        }
        size?.constraint(view: stack, maxSize: maxSize)
        return stack
    }
}
