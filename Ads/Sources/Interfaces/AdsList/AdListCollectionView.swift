//
//  AdListCollectionView.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import LeboncoinUIKit
import UIKit

final class AdCollectionView: UICollectionView {
    init() {
        super.init(
            frame: .zero,
            collectionViewLayout: Self.createLayout()
        )
        setupView()
    }

    required init?(coder: NSCoder) {
        nil
    }
}

private extension AdCollectionView {
    func setupView() {
        backgroundColor = .App.background
        translatesAutoresizingMaskIntoConstraints = false
        register(AdCell.self, forCellWithReuseIdentifier: AdCell.identifier)
    }

    static func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(96)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(96)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12

        return UICollectionViewCompositionalLayout(section: section)
    }
}
