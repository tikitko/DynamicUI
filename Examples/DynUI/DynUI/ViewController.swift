//
//  ViewController.swift
//  DynUI
//
//  Created by Mikita Bykau on 4.02.22.
//

import UIKit
import DynamicUI

final class ViewController: UIViewController {
    
    private let routesCollection: RoutesCollection
    
    required init?(coder: NSCoder) {
        routesCollection = DynamicRoutesCollectionBuilder(defaultItemType: Never.self)
            .itemType(CustomLabelItem.self, on: "custom")
            .itemType(BigItem.self, on: "big")
            .finish()
        
        super.init(coder: coder)
    }
    
    private var alradyPresented = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard !alradyPresented else {
            return
        }
        alradyPresented = true
        
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false) { [routesCollection] in
            let routesCollectionCoordinator = RoutesCollectionCoordinator(
                navigationController: navigationController,
                routesCollection: routesCollection
            )
            let coordinator = Coordinator(
                navigationController: navigationController,
                routesCollectionCoordinator: routesCollectionCoordinator
            )
            routesCollectionCoordinator.rootCoordinator = coordinator
            coordinator.start()
        }
    }
    
}

final class Coordinator {
    let navigationController: UINavigationController
    let routesCollectionCoordinator: RoutesCollectionCoordinator
    init(
        navigationController: UINavigationController,
        routesCollectionCoordinator: RoutesCollectionCoordinator
    ) {
        self.navigationController = navigationController
        self.routesCollectionCoordinator = routesCollectionCoordinator
    }
    func start() {
        routesCollectionCoordinator.navigate(to: "home", params: ["resourcePath": Bundle.main.resourcePath ?? ""])
    }
}

extension Coordinator: CoordinatorProtocol {
    func navigate(to routePath: String, params: [String: Any], animated: Bool, completion: @escaping  (Error?) -> Void) {
        let routePathComponents = routePath.split(separator: ";")
        guard routePathComponents.count == 3,
            routePathComponents[0] == "alert" else {
                routesCollectionCoordinator.navigate(to: routePath, params: params, animated: animated, completion: completion)
                return
        }
        let title = String(routePathComponents[1])
        let message = String(routePathComponents[2])
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        navigationController.present(alert, animated: true) {
            completion(nil)
        }
    }
}

