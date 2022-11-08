//
//  RecipeInteractorTest.swift
//  Softxpert-VIPERTests
//
//  Created by kareem chetoos on 31/10/2022.
//

import XCTest
@testable import Softxpert_VIPER

class RecipeListInteractorTest: XCTestCase {
        
    var interactor: RecipeListInteractor?
    var presenter: RecipeListPresenterMock?
    var localDataManager: RecipeListLocalDataMock?
    var remoteDataManger: RecipeListRemoteDataManagerMock?
    
    override func setUp() {
        super.setUp()
        interactor = RecipeListInteractor()
        presenter = RecipeListPresenterMock()
        localDataManager = RecipeListLocalDataMock()
        remoteDataManger = RecipeListRemoteDataManagerMock()
        interactor?.presenter = presenter
        interactor?.localDataManager = localDataManager
        interactor?.remoteDataManager = remoteDataManger
        presenter?.interactor = interactor
        remoteDataManger?.interactor = interactor
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRetriveHistoryFromLocalDataIfFoundData() {
        interactor?.saveHistory(searchText: "kareem")
        interactor?.retriveHistory()
        XCTAssertEqual(presenter?.historyCount, 3)
    }
    
    func testIsValidLaterWhenItTrue() {
       let result = interactor?.isValidateEnglishLetters(text: "Kareem")
        XCTAssertTrue(result!, "Should return True")
    }
    
    func testRetriveHistoryFromLocalDataIfFoundError() {
        presenter?.error = .emptyData
        localDataManager?.error = .emptyData
        interactor?.retriveHistory()
    }
    
    func testSaveDataFromLocalDataIfFoundError() {
        presenter?.error = .failed
        localDataManager?.error = .failed
        interactor?.saveHistory(searchText: "Text")
    }
    
    func testIsValidLaterWithArabicLater() {
       let result = interactor?.isValidateEnglishLetters(text: "كريم")
        XCTAssertFalse(result!, "Should return False")
    }
    
    func testIsValidWhiteSpacesNotValid() {
        let result = interactor?.isValidWhiteSpaces(searchText: "   ")
        XCTAssertFalse(result!, "Should return False")
    }
    
    func testIsValidWhiteSpacesValid() {
        let result = interactor?.isValidWhiteSpaces(searchText: "Kareem Abdo")
        XCTAssertTrue(result!, "Should return True")
    }
    
    func testOnReciveError() {
        remoteDataManger?.error = .failed
        presenter?.error = .failed
        
        interactor?.retriveRecipeList(searchText: "Kareem", from: 1, to: 1, filter: "")
    }
    
    
    func testOnReciveDataWithEmptyHits() {
        remoteDataManger?.error = nil
        remoteDataManger?.recipeModel = RecipesModel(q: "", from: 1, to: 1, more: false, count: 4, hits: nil)
        presenter?.error = .emptyData
        interactor?.retriveRecipeList(searchText: "Kareem", from: 1, to: 1, filter: "")
    }
    
    
    func testOnReciveDataWithEmptyData() {
        remoteDataManger?.error = nil
        remoteDataManger?.recipeModel = RecipesModel(q: "", from: 1, to: 1, more: false, count: 0, hits: [Hits(recipe: nil)])
        presenter?.error = .noRecipes
        interactor?.retriveRecipeList(searchText: "Kareem", from: 1, to: 1, filter: "")
    }

    func testOnReciveDataWithTextInvaid() {
        remoteDataManger?.error = nil
        remoteDataManger?.recipeModel = RecipesModel(q: "", from: 1, to: 1, more: false, count: 0, hits: [Hits(recipe: nil)])
        presenter?.error = .textSearchInvalid
        interactor?.retriveRecipeList(searchText: "", from: 1, to: 1, filter: "")
    }
}

