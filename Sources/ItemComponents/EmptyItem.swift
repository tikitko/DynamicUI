//
//  EmptyItem.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 7.02.22.
//

import Foundation
import UIKit

public struct EmptyItem: Decodable {
    public let size: Size?
}

extension EmptyItem: ItemProtocol {
    public func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        size?.constraint(view: view, maxSize: maxSize)
        return view
    }
}
