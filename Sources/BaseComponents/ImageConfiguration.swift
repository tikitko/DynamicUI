//
//  ImageConfiguration.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 8.02.22.
//

import Foundation
import UIKit

public struct ImageConfiguration: Decodable {
    public let color: Rgba
}

extension ImageConfiguration {
    var uiConfiguration: UIImage.Configuration {
        UIImage.SymbolConfiguration(hierarchicalColor: color.uiColor)
    }
}
