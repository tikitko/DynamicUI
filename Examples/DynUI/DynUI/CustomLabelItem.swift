//
//  CustomLabelItem.swift
//  DynUI
//
//  Created by Mikita Bykau on 4.02.22.
//

import Foundation
import UIKit
import DynamicUI

enum CustomLabelItem: String, Decodable {
    case variant1
    case variant2
}

extension CustomLabelItem: ItemProtocol {
    func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        switch self {
        case .variant1:
            label.text = "KEK"
        case .variant2:
            label.text = "WAT"
        }
        //label.widthAnchor.constraint(equalToConstant: maxSize.width).isActive = true
        //label.heightAnchor.constraint(equalToConstant: maxSize.height).isActive = true
        return label
    }
}

extension CustomLabelItem: CustomItemProtocol {
    static var name: String {
        "custom_label"
    }
}
