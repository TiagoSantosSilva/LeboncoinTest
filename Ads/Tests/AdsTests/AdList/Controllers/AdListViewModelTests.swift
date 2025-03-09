//
//  AdListViewModelTests.swift
//  Ads
//
//  Created by Tiago Silva on 09/03/2025.
//

import Testing
@testable import Ads

@Suite
final class AdListViewModelTests {
    private var sut: AdListViewModel!
    private var adListInteractorMock: AdListInteractorMock!
    private var currencyInteractorMock: CurrencyInteractorMock!

    init() {
        adListInteractorMock = AdListInteractorMock()
        currencyInteractorMock = CurrencyInteractorMock()
    }

    @Test("Emits adsLoaded action when ads are loaded successfully")
    func testEmitsAdsLoadedOnSuccess() async throws {
        let ads = [Ad.sample(id: 1, title: "Test Ad")]
        adListInteractorMock.loadAdsReturnValue = ads
        adListInteractorMock.loadAdsError = nil

        var receivedAction: AdListViewModel.Action?

        sut = AdListViewModel(
            interactor: adListInteractorMock,
            currencyInteractor: currencyInteractorMock
        )

        sut.didRequestAction = { action in
            receivedAction = action
        }

        sut.didChange(state: .didLoad)

        try await Task.sleep(nanoseconds: 100_000_000)

        guard
            case let .adsLoaded(loadedAds) = receivedAction
        else {
            #expect(Bool(false), "Expected .adsLoaded action, but got \(String(describing: receivedAction))")
            return
        }

        #expect(loadedAds == ads)
    }

    @Test("Emits error action when loading ads fails")
    func testEmitsErrorOnFailure() async throws {
        let expectedError = TestError.someError
        adListInteractorMock.loadAdsError = expectedError

        var receivedAction: AdListViewModel.Action?

        sut = AdListViewModel(
            interactor: adListInteractorMock,
            currencyInteractor: currencyInteractorMock
        )

        sut.didRequestAction = { action in
            receivedAction = action
        }

        sut.didChange(state: .didLoad)

        try await Task.sleep(nanoseconds: 100_000_000)

        guard
            case let .error(receivedError) = receivedAction
        else {
            #expect(Bool(false), "Expected .error action, but got \(String(describing: receivedAction))")
            return
        }

        #expect(receivedError as? TestError == expectedError)
    }
}
