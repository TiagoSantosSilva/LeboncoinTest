//
//  AdCell.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import LeboncoinUIKit
import SwiftUI
import UIKit

final class AdCell: UICollectionViewCell {
    static let identifier = "AdCollectionViewCell"

    private let adImageView = UIImageView()
    private let titleLabel = UILabel()
    private let categoryLabel = UILabel()
    private let priceLabel = UILabel()
    private let urgentIndicator = UILabel()
    private var imageTask: URLSessionDataTask?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
        setUpHierarchy()
        setUpStyles()
        setUpBehaviors()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        adImageView.cancelImageLoading()
        adImageView.image = nil
        titleLabel.text = nil
        categoryLabel.text = nil
        priceLabel.text = nil
        urgentIndicator.isHidden = true
    }

    func configure(with ad: Ad) {
        titleLabel.text = ad.title
        categoryLabel.text = ad.category
        priceLabel.text = ad.price
        urgentIndicator.isHidden = !ad.isUrgent

        adImageView.loadImage(
            from: ad.images
        )
    }
}

private extension AdCell {
    func setUpSubviews() {
        [
            adImageView,
            titleLabel,
            categoryLabel,
            priceLabel,
            urgentIndicator
        ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func setUpHierarchy() {
        NSLayoutConstraint.activate([
            adImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, spacing: .pt16),
            adImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            adImageView.heightAnchor.constraint(equalToConstant: 48),
            adImageView.widthAnchor.constraint(equalToConstant: 48),

            titleLabel.leadingAnchor.constraint(equalTo: adImageView.trailingAnchor, spacing: .pt16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, spacing: .pt16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: priceLabel.leadingAnchor, negativeSpacing: .pt16),

            categoryLabel.leadingAnchor.constraint(equalTo: adImageView.trailingAnchor, spacing: .pt16),
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, spacing: .pt4),
            categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: priceLabel.leadingAnchor, negativeSpacing: .pt16),
            categoryLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, negativeSpacing: .pt16),

            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, negativeSpacing: .pt16),
            priceLabel.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor),

            urgentIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, negativeSpacing: .pt16),
            urgentIndicator.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, spacing: .pt4)
        ])
    }

    func setUpStyles() {
        contentView.backgroundColor = .App.cell
        layer.cornerRadius = 12
        clipsToBounds = true

        adImageView.contentMode = .scaleAspectFit
        adImageView.clipsToBounds = true
        adImageView.layer.cornerRadius = 24
        adImageView.backgroundColor = .systemGray6
        adImageView.tag = 100

        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2

        categoryLabel.font = .systemFont(ofSize: 14, weight: .regular)
        categoryLabel.textColor = .systemGray

        priceLabel.font = .systemFont(ofSize: 16, weight: .medium)
        priceLabel.textColor = .white
        priceLabel.textAlignment = .right

        urgentIndicator.text = "Urgent"
        urgentIndicator.font = .systemFont(ofSize: 12, weight: .medium)
        urgentIndicator.textColor = .systemOrange
        urgentIndicator.textAlignment = .right
        urgentIndicator.isHidden = true
    }

    func setUpBehaviors() {
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}

private struct AdCollectionViewCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let cell = AdCell(frame: CGRect(x: 0, y: 0, width: 380, height: 80))

        let mockAd = Ad(
            id: 123456789,
            category: "Phones",
            title: "iPhone 12 Pro Max",
            description: "Like new iPhone 12 Pro Max",
            price: "799.00 €",
            images: .init(
                small: nil,
                thumbnail: nil
            ),
            isUrgent: true,
            creationDate: ""
        )

        cell.configure(with: mockAd)

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
        containerView.backgroundColor = .black
        containerView.addSubview(cell)
        cell.center = containerView.center

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    AdCollectionViewCellPreview()
        .preferredColorScheme(.dark)
}
