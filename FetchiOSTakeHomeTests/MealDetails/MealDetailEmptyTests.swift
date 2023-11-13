//
//  MealDetailEmptyTests.swift
//  FetchiOSTakeHomeTests
//
//  Created by Najia Haider on 11/12/23.
//

import XCTest
@testable import FetchiOSTakeHome

final class MealDetailEmptyTests: XCTestCase {
    private var networkMock: NetworkManagerProtocol!
    private var viewModel: MealDetailViewModel!
    
    override func setUpWithError() throws {
        self.networkMock = NetworkSuccessMock(file: .emptyDessertDetail)
        self.viewModel = MealDetailViewModel(networkManager: networkMock)
    }
    
    override func tearDownWithError() throws {
        networkMock = nil
        viewModel = nil
    }
    
    func test_errorIsTrue_whenMealsEmpty() async throws {
        await viewModel.fetchDessertInfo(id: 52893)
        
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
        
        XCTAssertEqual(viewModel.error?.localizedDescription, "API Doesn't Contain Data for this Meal")
    }
}
