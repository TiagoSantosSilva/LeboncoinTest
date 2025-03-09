//
//  AdListViewModel.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Pandora
import UIKit

protocol AdListViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: AdListViewModel, didTap ad: Ad)
}

final class AdListViewModel {
    enum Action {
        case adsLoaded([Ad])
        case error(Error)
    }

    var didRequestAction: ((Action) -> Void)? = { _ in
        assertionFailure("This should be configured before loading data")
    }
    weak var delegate: AdListViewModelDelegate?
    private let interactor: AdListInteractorProtocol
    private let currencyInteractor: CurrencyInteractorProtocol
    private var ads: [Ad] = []

    init(
        interactor: AdListInteractorProtocol,
        currencyInteractor: CurrencyInteractorProtocol
    ) {
        self.interactor = interactor
        self.currencyInteractor = currencyInteractor
    }

    convenience init() {
        self.init(
            interactor: AdListInteractor(),
            currencyInteractor: CurrencyInteractor()
        )
    }

    func didChange(state: UIViewController.Lifecycle) {
        switch state {
        case .didLoad:
            loadData()
        default:
            break
        }
    }

    func tap(on indexPath: IndexPath) {
        delegate?.viewModel(self, didTap: ads[indexPath.row])
    }
}

private extension AdListViewModel {
    func loadData() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let ads = try await interactor.loadAds(displayCurrency: currencyInteractor.displayCurrency)
                self.ads = ads
                didRequestAction?(.adsLoaded(ads))
            } catch {
                didRequestAction?(.error(error))
            }
        }
    }
}
