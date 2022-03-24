//
//  Image.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 8.02.22.
//

import Foundation
import UIKit

public enum Image: Decodable {
    //case remote(url: URL)
    case local(name: String)
    case system(name: String, configuration: ImageConfiguration?)
}

extension Image {
    func uiImage(params: [String: Any]) -> UIImage? {
        switch self {
        case .local(name: let name):
            guard let resourcePath = params["resourcePath"] as? String else {
                fatalError("Should be `resourcePath`.")
            }
            return UIImage(contentsOfFile: resourcePath + "/" + name)
        case .system(name: let name, configuration: let configuration):
            return UIImage(systemName: name, withConfiguration: configuration?.uiConfiguration)
        }
    }
}
