//
//  BigViewModel.swift
//  DynUI
//
//  Created by Mikita Bykau on 4.02.22.
//

import Foundation
import Combine

protocol BigViewModelProtocol: AnyObject {
    var text: Published<String?>.Publisher { get }
    func start()
    func stop()
}

final class BigViewModel: BigViewModelProtocol {
    @Published private var _text: String?
    private var cancellable: Cancellable?
    
    var text: Published<String?>.Publisher { $_text }
    func start() {
        cancellable = Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .map { String($0.timeIntervalSince1970) }
            .assign(to: \._text, on: self)
    }
    
    func stop() {
        cancellable?.cancel()
        cancellable = nil
    }
}
