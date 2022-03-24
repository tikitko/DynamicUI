//
//  CoordinatorProtocol.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 5.02.22.
//

import Foundation

public protocol CoordinatorProtocol: AnyObject {
    func navigate(to routePath: String, params: [String: Any], animated: Bool, completion: @escaping (Error?) -> Void)
}

extension CoordinatorProtocol {
    public func navigate(to routePath: String, params: [String: Any], animated: Bool = true, completion: @escaping (Error?) -> Void = { _ in }) {
        navigate(to: routePath, params: params, animated: animated, completion: completion)
    }
}
