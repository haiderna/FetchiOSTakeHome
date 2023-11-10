//
//  DessertViewModelFailureTests.swift
//  FetchiOSTakeHomeTests
//
//  Created by Najia Haider on 11/10/23.
//

import XCTest
@testable import FetchiOSTakeHome

final class DessertViewModelFailureTests: XCTestCase {
    private var networkMock: NetworkManagerProtocol!
    private var viewModel: DessertViewModel!

    override func setUpWithError() throws {
        self.networkMock = NetworkFailureMock()
        self.viewModel = DessertViewModel(networkManager: networkMock)
    }

    override func tearDownWithError() throws {
       
        networkMock = nil
        viewModel = nil
    }
    
    func test_errorIsTrueAndNotNil_whenCallFails() async throws {
        await viewModel.getDesserts()
        
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }

}
