//
//  CustomItemProtocol.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 7.02.22.
//

import Foundation

public protocol CustomItemProtocol: ItemProtocol {
    static var name: String { get }
}

extension Never: CustomItemProtocol {
    public static var name: String {
        ""
    }
}
