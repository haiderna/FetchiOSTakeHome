//
//  FetchiOSTakeHomeTests.swift
//  FetchiOSTakeHomeTests
//
//  Created by Najia Haider on 11/4/23.
//

import XCTest
@testable import FetchiOSTakeHome

final class DessertViewModelTests: XCTestCase {
    private var networkMock: NetworkManagerProtocol!
    private var viewModel: DessertViewModel!

    override func setUpWithError() throws {
        self.networkMock = NetworkSuccessMock(file: .dessertList)
        self.viewModel = DessertViewModel(networkManager: networkMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkMock = nil
        viewModel = nil
    }

    func test_arrayCount_when_calling_getDesserts() async throws {
        await viewModel.getDesserts()
        XCTAssertEqual(viewModel.desserts.count, 7)
    }
    
    func test_whenGetDessertsCalled_resultIsAlphabetical() async throws {
        await viewModel.getDesserts()
        
        var expectedRes = ["Apam balik", "Apple & Blackberry Crumble", "Apple Frangipan Tart", "Battenberg Cake", "BeaverTails", "Budino Di Ricotta", "Canadian Butter Tarts"]
        
        var actualRes = viewModel.desserts.map { $0.strMeal }
        
        XCTAssertEqual(expectedRes, actualRes)
    }
    
    func test_afterSuccessfulCall_showErrorAlertIsFalse() async throws {
        await viewModel.getDesserts()
        
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertNil(viewModel.error)
    }

}
