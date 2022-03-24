//
//  DynamicRoutesCollectionBuilder.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 5.02.22.
//

import Foundation
import UIKit

public struct DynamicRoutesCollectionBuilder {
    private let routesCollection: RoutesCollection
    private let fileManager: FileManager
    private let bundle: Bundle
    private let jsonDecoder: JSONDecoder
    
    private init(
        routesCollection: RoutesCollection,
        fileManager: FileManager,
        bundle: Bundle,
        jsonDecoder: JSONDecoder
    ) {
        self.routesCollection = routesCollection
        self.fileManager = fileManager
        self.bundle = bundle
        self.jsonDecoder = jsonDecoder
    }
    
    public init<I>(
        defaultItemType: I.Type,
        fileManager: FileManager = .default,
        bundle: Bundle = .main,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) where I: CustomItemProtocol, I: Decodable {
        self.init(
            routesCollection: RoutesCollection(
                routes: [:],
                defaultRoute: { routePath in
                    return routePath.dynamicRouteCallback(
                        itemType: defaultItemType,
                        fileManager: fileManager,
                        bundle: bundle,
                        jsonDecoder: jsonDecoder
                    )
                }
            ),
            fileManager: fileManager,
            bundle: bundle,
            jsonDecoder: jsonDecoder
        )
    }

    public func itemType<I>(_ itemType: I.Type, on routePath: String) -> DynamicRoutesCollectionBuilder where I: CustomItemProtocol, I: Decodable {
        var routes = routesCollection.routes
        let defaultRoute = routesCollection.defaultRoute
        
        routes[routePath] = routePath.dynamicRouteCallback(
            itemType: itemType,
            fileManager: fileManager,
            bundle: bundle,
            jsonDecoder: jsonDecoder
        )
        
        return DynamicRoutesCollectionBuilder(
            routesCollection: RoutesCollection(
                routes: routes,
                defaultRoute: defaultRoute
            ),
            fileManager: fileManager,
            bundle: bundle,
            jsonDecoder: jsonDecoder
        )
    }
    
    public func finish() -> RoutesCollection {
        routesCollection
    }
}
