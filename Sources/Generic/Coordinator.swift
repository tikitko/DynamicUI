//
//  Coordinator.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 5.02.22.
//

import Foundation
import UIKit

public final class RoutesCollectionCoordinator {
    private let navigationController: UINavigationController
    private let routesCollection: RoutesCollection
    public weak var rootCoordinator: CoordinatorProtocol?
    public init(navigationController: UINavigationController, routesCollection: RoutesCollection) {
        self.navigationController = navigationController
        self.routesCollection = routesCollection
    }
}

extension RoutesCollectionCoordinator: CoordinatorProtocol {
    public func navigate(to routePath: String, params: [String : Any], animated: Bool, completion: (Error?) -> Void) {
        let routeCallback = routesCollection.routeCallback(for: routePath)
        do {
            let viewController = try routeCallback(params, rootCoordinator ?? self)
            navigationController.pushViewController(viewController, animated: animated)
            completion(nil)
        } catch {
            print("RoutesCollectionCoordinator navigate error: \(error)")
            completion(error)
        }
    }
}
