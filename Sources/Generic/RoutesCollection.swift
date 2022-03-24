//
//  RoutesCollection.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 5.02.22.
//

import Foundation
import UIKit

public struct RoutesCollection {
    typealias RouteCallback = ([String: Any], CoordinatorProtocol) throws -> UIViewController
    let routes: [String: RouteCallback]
    let defaultRoute: (String) -> RouteCallback
    
    func routeCallback(for routePath: String) -> RouteCallback {
        guard let routeCallback = routes[routePath] else {
            return defaultRoute(routePath)
        }
        return routeCallback
    }
}
