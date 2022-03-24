//
//  BigView.swift
//  DynUI
//
//  Created by Mikita Bykau on 4.02.22.
//

import Foundation
import UIKit
import Combine

final class BigView: UIView {
    private var cancellableBag = Set<AnyCancellable>()
    private let label: UILabel = UILabel()
    
    private var viewModel: BigViewModelProtocol? {
        willSet {
            removeViewModel()
        }
        didSet {
            bindViewModel()
        }
    }
    
    func removeViewModel() {
        cancellableBag.forEach { $0.cancel() }
        cancellableBag = Set([])
    }
    
    func bindViewModel() {
        viewModel?.text
            .assign(to: \.text, on: label)
            .store(in: &cancellableBag)
    }
    
    init(viewModel: BigViewModelProtocol) {
        super.init(frame: .zero)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 0).isActive = true
        label.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0).isActive = true
        label.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0).isActive = true
        label.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: 0).isActive = true
        
        label.textAlignment = .center
        
        self.viewModel = viewModel
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        viewModel?.start()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        viewModel?.stop()
    }
    

}

