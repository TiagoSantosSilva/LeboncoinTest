//
//  AdDetailsView.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import LeboncoinUIKit
import Pandora
import SwiftUI

struct AdDetailsView: View {
    let viewModel: AdDetailsViewModel

    private typealias L10n = Localized.Ads.Details

    var body: some View {
        ScrollView {
            VStack(spacing: .pt16) {
                productImageView
                productInfoView
                descriptionView
            }
            .padding(spacing: .pt8)
        }
        .background(Color.App.background)
    }
}

private extension AdDetailsView {
    var productImageView: some View {
        CachedImage(
            url: viewModel.ad.images.small,
            thumbnail: viewModel.ad.images.thumbnail
        )
        .frame(height: 250)
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
    }

    var productInfoView: some View {
        VStack(alignment: .leading, spacing: .pt12) {
            titleRow
            categoryRow
            priceRow
            dateRow
        }
        .padding(spacing: .pt16)
        .background(Color.App.cardBackground)
        .cornerRadius(12)
    }

    var titleRow: some View {
        HStack(alignment: .top) {
            Text(viewModel.ad.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.App.label)

            Spacer()

            if viewModel.ad.isUrgent {
                UrgentBadge()
            }
        }
    }

    var categoryRow: some View {
        HStack {
            Image(systemName: "tag")
                .foregroundColor(.App.secondaryLabel)

            Text(viewModel.ad.category)
                .foregroundColor(Color.App.secondaryLabel)
        }
    }

    var priceRow: some View {
        HStack {
            Spacer()

            Text(viewModel.ad.price)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.App.label)

            Spacer()
        }
        .padding(.vertical, spacing: .pt8)
    }

    var dateRow: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(Color.App.secondaryLabel)

            Text(L10n.Posted.value(viewModel.ad.creationDate))
                .foregroundColor(Color.App.secondaryLabel)
        }
    }

    var descriptionView: some View {
        VStack(alignment: .leading, spacing: .pt12) {
            Text(L10n.Description.title)
                .font(.headline)
                .foregroundColor(Color.App.label)

            Text(viewModel.ad.description)
                .foregroundColor(Color.App.label)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(spacing: .pt16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.App.cardBackground)
        .cornerRadius(12)
    }
}

#Preview {
    AdDetailsView(
        viewModel: .init(
            ad: .init(
                id: 1,
                category: "Tech",
                title: "iPhone 16 Pro Max",
                description: "Beautiful smartphone in perfect condition. Comes with original box and accessories. Battery health at 95%. No scratches on screen or body. Selling because I'm upgrading to the newer model.",
                price: "999.99€",
                images: .init(small: nil, thumbnail: nil),
                isUrgent: true,
                creationDate: "09-03-2025 at 20:21:53"
            )
        )
    )
    .preferredColorScheme(.dark)
}
