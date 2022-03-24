//
//  ItemProtocol.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 6.02.22.
//

import Foundation
import UIKit

public protocol ItemProtocol {
    func buildView(params: [String: Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView
}

extension Never: Decodable {
    public init(from decoder: Decoder) throws {
        throw DecodingError.dataCorrupted(DecodingError.Context(
            codingPath: decoder.codingPath,
            debugDescription: "Can not decode never type",
            underlyingError: nil
        ))
    }
}

extension Never: ItemProtocol {
    public func buildView(params: [String: Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        fatalError()
    }
}
