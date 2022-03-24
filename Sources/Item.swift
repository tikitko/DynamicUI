//
//  Item.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 4.02.22.
//

import Foundation
import UIKit

public indirect enum Item<I> where I: CustomItemProtocol, I: Decodable {
    case stack(StackItem<I>)
    case collection(CollectionItem<I>)
    case scroll(ScrollItem<I>)
    
    case web(WebItem)
    case button(ButtonItem)
    case label(LabelItem)
    case image(ImageItem)
    case empty(EmptyItem)
    
    case custom(I)
}

extension Item: Decodable {
    fileprivate enum CodingKeys {
        case stack
        case collection
        case scroll
        
        case web
        case button
        case label
        case image
        case empty
        
        case custom
        case any
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let stack = try container.decodeIfPresent(StackItem<I>.self, forKey: .stack) {
            self = .stack(stack)
        } else if let collection = try container.decodeIfPresent(CollectionItem<I>.self, forKey: .collection) {
            self = .collection(collection)
        } else if let scroll = try container.decodeIfPresent(ScrollItem<I>.self, forKey: .scroll) {
            self = .scroll(scroll)
        } else if let web = try container.decodeIfPresent(WebItem.self, forKey: .web) {
            self = .web(web)
        } else if let button = try container.decodeIfPresent(ButtonItem.self, forKey: .button) {
            self = .button(button)
        } else if let label = try container.decodeIfPresent(LabelItem.self, forKey: .label) {
            self = .label(label)
        } else if let image = try container.decodeIfPresent(ImageItem.self, forKey: .image) {
            self = .image(image)
        } else if let empty = try container.decodeIfPresent(EmptyItem.self, forKey: .empty) {
            self = .empty(empty)
        } else if let customItem = try container.decodeIfPresent(I.self, forKey: .custom) {
            self = .custom(customItem)
        } else {
            throw DecodingError.keyNotFound(
                CodingKeys.any,
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "No one key found",
                    underlyingError: nil
                )
            )
        }
    }
}

extension Item.CodingKeys: CodingKey {
    init?(stringValue: String) {
        switch stringValue {
        case "stack":
            self = .stack
        case "collection":
            self = .collection
        case "scroll":
            self = .scroll
        case "web":
            self = .web
        case "button":
            self = .button
        case "label":
            self = .label
        case "image":
            self = .image
        case "empty":
            self = .empty
        case I.name:
            self = .custom
        default:
            self = .any
        }
    }
    
    var stringValue: String {
        switch self {
        case .stack:
            return "stack"
        case .collection:
            return "collection"
        case .scroll:
            return "scroll"
        case .web:
            return "web"
        case .button:
            return "button"
        case .label:
            return "label"
        case .image:
            return "image"
        case .empty:
            return "empty"
        case .custom:
            return I.name
        case .any:
            return "any"
        }
    }
}

extension Item {
    var innerItem: ItemProtocol {
        switch self {
        case .stack(let stack):
            return stack
        case .collection(let collection):
            return collection
        case .scroll(let scroll):
            return scroll
        case .web(let web):
            return web
        case .button(let button):
            return button
        case .label(let label):
            return label
        case .image(let image):
            return image
        case .empty(let empty):
            return empty
        case .custom(let custom):
            return custom
        }
    }
}

extension Item: ItemProtocol {
    public func buildView(params: [String: Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        innerItem.buildView(params: params, coordinator: coordinator, maxSize: maxSize)
    }
}
