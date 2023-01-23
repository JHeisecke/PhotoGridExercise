//
//  HeroesLayoutViewModelTest.swift
//  PhotoGridAppTests
//
//  Created by Javier Heisecke on 2022-06-05.
//

import XCTest
@testable import PhotoGridApp

class HeroesLayoutViewModelTest: XCTestCase {

    private var viewModel: HeroesLayoutViewModel!
    private var repository: HeroesRepositoryStub! = HeroesRepositoryStub()
    
    override func setUpWithError() throws {
        viewModel = HeroesLayoutViewModel(getHeroesUseCase: GetHeroesUseCase(repository: repository))
    }

    override func tearDownWithError() throws {
        repository = nil
        viewModel = nil
    }
    
    func testGetHerosWithSuccess() {
        viewModel.getHeroes()
        XCTAssertNotNil(viewModel.heroes.value)
    }
    
    func testGetHerosWithFailure() {
        repository.hasError = true
        viewModel.getHeroes()
        XCTAssertNotNil(viewModel.error.value)
    }
}
