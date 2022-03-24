//
//  WebItem.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 7.02.22.
//

import Foundation
import UIKit
import WebKit

public struct WebItem: Decodable {
    public let url: URL
    public let size: Size?
}

extension WebItem: ItemProtocol {
    public func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {

        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        size?.constraint(view: webView, maxSize: maxSize)
        return webView
    }
}
