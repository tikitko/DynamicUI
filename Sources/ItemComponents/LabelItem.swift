//
//  LabelItem.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 7.02.22.
//

import Foundation
import UIKit

public struct LabelItem: Decodable {
    public let text: Text
    public let size: Size?
}

extension LabelItem: ItemProtocol {
    public func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        let label = UILabel()
        text.apply(to: label)
        size?.constraint(view: label, maxSize: maxSize)
        return label
    }
}
