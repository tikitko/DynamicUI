//
//  ImageItem.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 7.02.22.
//

import Foundation
import UIKit

public struct ImageItem: Decodable {
    public let value: Image
    public let size: Size?
}

extension ImageItem: ItemProtocol {
    public func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        let image = value.uiImage(params: params)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        size?.constraint(view: imageView, maxSize: maxSize)
        return imageView
    }
}
