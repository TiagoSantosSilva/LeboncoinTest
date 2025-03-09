//
//  AdsList.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import LeboncoinUIKit
import UIKit

final class AdListViewController: UIViewController {
    private let viewModel: AdListViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Ad>?

    private lazy var collectionView = {
        let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(96) // Set height to 64pt as requested
            )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(96) // Match item height
            )

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            // Add padding to the group instead of the item
            group.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 16, // Left padding
                bottom: 0,
                trailing: 16 // Right padding
            )

            let section = NSCollectionLayoutSection(group: group)

            // Add spacing between items
            section.interGroupSpacing = 12 // Space between cells

        let layout = UICollectionViewCompositionalLayout(section: section)
        return UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
    }()

    enum Section {
        case main
    }

    init(viewModel: AdListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpHierarchy()
        setUpStyles()
        setUpContent()
        setUpCollectionView()
        setUpDataSource()
        setUpBehaviors()

        viewModel.didChange(state: .didLoad)
    }
}

private extension AdListViewController {
    func setUpViews() {
        view.addSubview(collectionView)
    }
    
    func setUpHierarchy() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func setUpContent() {
        navigationItem.title = "Ads"
    }

    func setUpStyles() {
        view.backgroundColor = .App.background
        collectionView.backgroundColor = .App.background
    }

    func setUpCollectionView() {
            collectionView.register(
                AdCell.self,
                forCellWithReuseIdentifier: AdCell.identifier
            )
            collectionView.delegate = self
        }

    func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Ad>(
            collectionView: collectionView
        ) { (collectionView, indexPath, ad) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AdCell.identifier,
                for: indexPath
            ) as? AdCell else {
                return UICollectionViewCell()
            }

            cell.configure(with: ad)

            return cell
        }
    }

    func applySnapshot(with ads: [Ad], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Ad>()
        snapshot.appendSections([.main])
        snapshot.appendItems(ads, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func setUpBehaviors() {
        viewModel.didRequestAction = { [weak self] action in
            switch action {
            case let .adsLoaded(ads):
                self?.applySnapshot(with: ads)
            case .error:
                break
            }
        }
    }
}

extension AdListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
