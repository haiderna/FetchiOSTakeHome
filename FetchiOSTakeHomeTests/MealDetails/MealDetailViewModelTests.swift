//
//  MealDetailViewModelTests.swift
//  FetchiOSTakeHomeTests
//
//  Created by Najia Haider on 11/8/23.
//

import XCTest
@testable import FetchiOSTakeHome

final class MealDetailViewModelTests: XCTestCase {
    private var networkMock: NetworkManagerProtocol!
    private var viewModel: MealDetailViewModel!

    override func setUpWithError() throws {
        self.networkMock = NetworkSuccessMock(file: .dessertDetail)
        self.viewModel = MealDetailViewModel(networkManager: networkMock)
    }

    override func tearDownWithError() throws {
        networkMock = nil
        viewModel = nil
    }

    func test_ingredientsListIsValid_UponSuccessfulCallOfFetchDetails() async throws {
        
        await viewModel.fetchDessertInfo(id: 52893)
        XCTAssertEqual(viewModel.ingredientsList.count, 9)
    }
    
    func test_NilAndEmptyValuesRemovedFromAnArray_UponCalling_removeNilsandEmpty(){
        let startingArray: [String?] = ["One", nil, "Two", "Three", ""]
        let endArray = viewModel.removeNilsandEmpty(arrayFromAPI: startingArray)
        
        let expectedArray = ["One", "Two", "Three"]
        XCTAssertEqual(endArray, expectedArray)
        
    }
    
    func test_stepsAreCombined_AfterCallingRoundUpIngredientsAndMeasurements() async throws {
        var ingredients = ["tomato", "cucumber", "avocado"]
        var measurements = ["1", "1/2 a bowl", "1/2 a cup"]
        
        let expectedArray = ["tomato: 1", "cucumber: 1/2 a bowl", "avocado: 1/2 a cup"]
        XCTAssertEqual(expectedArray, viewModel.roundUpIngredientsAndMeasurements(optIngredients: ingredients, optMeasurements: measurements))
    }
    
    func test_ingredeintsListParsedAndCombined_AfterCallingAPI() async throws {
        await viewModel.fetchDessertInfo(id: 52893)
                                         
        let expectedArray = ["Plain Flour: 120g", "Caster Sugar: 60g", "Butter: 60g", "Braeburn Apples: 300g", "Butter: 30g", "Demerara Sugar: 30g", "Blackberrys: 120g", "Cinnamon: ¼ teaspoon", "Ice Cream: to serve"]
        XCTAssertEqual(expectedArray[2], viewModel.ingredientsList[2])
    }
    
    func test_showAlertFalse_whenCallIsSuccessful() async throws {
        await viewModel.fetchDessertInfo(id: 52893)
        
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }

}
