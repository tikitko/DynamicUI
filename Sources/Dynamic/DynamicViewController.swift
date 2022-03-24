//
//  DynamicViewController.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 4.02.22.
//

import Foundation
import UIKit

public final class DynamicViewController<I>: UIViewController where I: CustomItemProtocol, I: Decodable {
    private let params: [String: Any]
    private let coordinator: CoordinatorProtocol
    private let item: Item<I>
    
    private var topView: UIView? {
        willSet {
            topView?.removeFromSuperview()
        }
        didSet {
            guard let topView = topView else {
                return
            }
            view.addSubview(topView)
            topView.translatesAutoresizingMaskIntoConstraints = false

            topView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0).isActive = true
            if topView.constraints.first(where: { $0.firstAttribute == .height })?.isActive != true {
                topView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
            }
            
            topView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
            if topView.constraints.first(where: { $0.firstAttribute == .width })?.isActive != true {
                topView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
            }
        }
    }
    
    private var lastMaxSize: CGSize?
    private func updateItemViewIfNeeded(to size: CGSize) {
        let safe = view.safeAreaInsets
        let maxSize = CGSize(width: size.width - safe.left - safe.right, height: size.height - safe.top - safe.bottom)
        guard lastMaxSize != maxSize else {
            return
        }
        lastMaxSize = maxSize
        topView = item.buildView(params: params, coordinator: self.coordinator, maxSize: maxSize)
    }
    
    public init(
        params: [String: Any],
        coordinator: CoordinatorProtocol,
        item: Item<I>
    ) {
        self.params = params
        self.coordinator = coordinator
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateItemViewIfNeeded(to: view.bounds.size)
    }
    
    public override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        updateItemViewIfNeeded(to: view.bounds.size)
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        updateItemViewIfNeeded(to: size)
    }

}
