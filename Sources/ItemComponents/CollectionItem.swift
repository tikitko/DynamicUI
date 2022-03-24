//
//  CollectionItem.swift
//  DynamicUI
//
//  Created by Mikita Bykau on 5.02.22.
//

import Foundation
import UIKit

public struct CollectionItem<I>: Decodable where I: CustomItemProtocol, I: Decodable {
    public let size: Size?
    public let defaultItemSize: Size?
    public let items: [Item<I>]
}

extension CollectionItem: ItemProtocol {
    public func buildView(params: [String : Any], coordinator: CoordinatorProtocol, maxSize: CGSize) -> UIView {
        let views = items.map { $0.buildView(params: params, coordinator: coordinator, maxSize: maxSize) }
        let collectionView = CollectionView(views: views, defaultItemSize: defaultItemSize?.maxUiSize(maxSize: maxSize) ?? maxSize)
        size?.constraint(view: collectionView, maxSize: maxSize)
        return collectionView
    }
}

private final class CollectionViewCell: UICollectionViewCell {
    private var lockConstraints: [NSLayoutConstraint] = []
    var view: UIView? {
        willSet {
            removeConstraints(lockConstraints)
            lockConstraints.removeAll()
            view?.removeFromSuperview()
        }
        didSet {
            guard let view = view else {
                return
            }
            
            addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            lockConstraints = [
                view.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 0),
                view.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0),
                view.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0),
                view.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: 0)
            ]
            lockConstraints.forEach { $0.isActive = true }
        }
    }
}

private final class FlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}

private final class CollectionView: UICollectionView {
    let views: [UIView]
    let defaultItemSize: CGSize
    init(views: [UIView], defaultItemSize: CGSize) {
        self.views = views
        self.defaultItemSize = defaultItemSize
        
        let flowLayout = FlowLayout()
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        dataSource = self
        delegate = self
        
        register(CollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CollectionViewCell.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let constraints = views[indexPath.item].constraints
        
        let width = constraints.first(where: { $0.firstAttribute == .width })?.constant ?? defaultItemSize.width
        let height = constraints.first(where: { $0.firstAttribute == .height })?.constant ?? defaultItemSize.height
        
        return CGSize(width: width, height: height)
    }
}

extension CollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as! CollectionViewCell
        cell.view = views[indexPath.item]
        return cell
    }
}
