//
//  Rgba.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 5.02.22.
//

import Foundation
import UIKit

public struct Rgba: Decodable {
    public let red: CGFloat
    public let green: CGFloat
    public let blue: CGFloat
    public let alpha: CGFloat?
}

extension Rgba {
    var uiColor: UIColor {
        UIColor(cgColor: CGColor(
            red: red,
            green: green,
            blue: blue,
            alpha: alpha ?? 1
        ))
    }
}
