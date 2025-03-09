//
//  AdListViewModel.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Pandora
import UIKit

final class AdListViewModel {
    enum Action {
        case adsLoaded([Ad])
        case error(Error)
    }

    var didRequestAction: ((Action) -> Void)? = { _ in
        assertionFailure("This should be configured before loading data")
    }
    private let interactor: AdListInteractorProtocol
    private let currencyInteractor: CurrencyInteractorProtocol

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
}

private extension AdListViewModel {
    func loadData() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let ads = try await interactor.loadAds(displayCurrency: currencyInteractor.displayCurrency)
                didRequestAction?(.adsLoaded(ads))
            } catch {
                didRequestAction?(.error(error))
            }
        }
    }
}
