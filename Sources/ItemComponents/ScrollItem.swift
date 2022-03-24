//
//  ScrollItem.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 7.02.22.
//

import Foundation
import UIKit

public struct ScrollItem<I>: Decodable where I: CustomItemProtocol, I: Decodable {
    public let item: Item<I>
    public let size: Size?
}

extension ScrollItem: ItemProtocol {
    public func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        let view = item.buildView(params: params, coordinator: coordinator, maxSize: maxSize)
        let scrollView = UIScrollView()
        scrollView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: 0).isActive = true
        view.topAnchor.constraint(equalToSystemSpacingBelow: scrollView.topAnchor, multiplier: 0).isActive = true
        view.leadingAnchor.constraint(equalToSystemSpacingAfter: scrollView.leadingAnchor, multiplier: 0).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: 0).isActive = true
        size?.constraint(view: scrollView, maxSize: maxSize)
        return scrollView
    }
}
