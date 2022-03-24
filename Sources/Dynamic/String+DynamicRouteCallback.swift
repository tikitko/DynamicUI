//
//  String+DynamicRouteCallback.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 6.02.22.
//

import Foundation

extension String {
    enum DynamicRouteCallbackPathError: Error {
        case pathIncorrect
        case pathNotExists
    }
    
    private struct Description<I>: Decodable where I: CustomItemProtocol, I: Decodable {
        let title: String?
        let item: Item<I>
    }

    func dynamicRouteCallback<I>(
        itemType: I.Type,
        fileManager: FileManager,
        bundle: Bundle,
        jsonDecoder: JSONDecoder
    ) -> RoutesCollection.RouteCallback where I: CustomItemProtocol, I: Decodable {
        { params, coordinator in
            guard let jsonLayoutPath = bundle.path(forResource: self, ofType: "json") else {
                throw DynamicRouteCallbackPathError.pathIncorrect
            }
            guard let data = fileManager.contents(atPath: jsonLayoutPath) else {
                throw DynamicRouteCallbackPathError.pathNotExists
            }
            let description = try jsonDecoder.decode(Description<I>.self, from: data)
            let viewController = DynamicViewController<I>(
                params: params,
                coordinator: coordinator,
                item: description.item
            )
            viewController.title = description.title
            viewController.modalPresentationStyle = .fullScreen
            return viewController
        }
    }
}
