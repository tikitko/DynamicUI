//
//  BigItem.swift
//  DynUI
//
//  Created by Mikita Bykau on 4.02.22.
//

import Foundation
import UIKit
import DynamicUI

struct BigItem: Decodable {}

extension BigItem: ItemProtocol {
    func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        let viewModel = BigViewModel()
        let view = BigView(viewModel: viewModel)
        view.widthAnchor.constraint(equalToConstant: maxSize.width).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }
}

extension BigItem: CustomItemProtocol {
    static var name: String {
        "big"
    }
}
