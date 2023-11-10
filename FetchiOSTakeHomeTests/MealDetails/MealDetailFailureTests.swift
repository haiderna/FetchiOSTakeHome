//
//  MealDetailFailureTests.swift
//  FetchiOSTakeHomeTests
//
//  Created by Najia Haider on 11/10/23.
//

import XCTest
@testable import FetchiOSTakeHome

final class MealDetailFailureTests: XCTestCase {
    private var networkMock: NetworkManagerProtocol!
    private var viewModel: MealDetailViewModel!

    override func setUpWithError() throws {
        self.networkMock = NetworkFailureMock()
        self.viewModel = MealDetailViewModel(networkManager: networkMock)
    }

    override func tearDownWithError() throws {
        networkMock = nil
        viewModel = nil
    }

    func test_errorIsTrueAndNotNil_whenCallFails() async throws {
        await viewModel.fetchDessertInfo(id: 1)
        
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }

}
