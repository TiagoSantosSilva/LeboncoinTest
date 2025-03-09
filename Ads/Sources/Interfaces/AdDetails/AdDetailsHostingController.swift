//
//  AdDetailsHostingController.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import SwiftUI
import UIKit

final class AdDetailsHostingController: UIHostingController<AdDetailsView> {
    init(viewModel: AdDetailsViewModel) {
        super.init(rootView: AdDetailsView(viewModel: viewModel))
        title = viewModel.ad.title
    }

    @MainActor
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
