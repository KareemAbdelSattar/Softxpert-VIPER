//
//  RecipeInteractorTest.swift
//  Softxpert-VIPERTests
//
//  Created by kareem chetoos on 31/10/2022.
//

import XCTest
@testable import Softxpert_VIPER

class RecipeListPresenterTestTest: XCTestCase {

    var presenter: RecipeListPresenter?
    var view = RecipeListVCMock()
    var interactor = RecipeListInteractorMock()
    
    override func setUp() {
        super.setUp()
        presenter = RecipeListPresenter()
        presenter?.view = view
        presenter?.interactor = interactor
        interactor.presenter = presenter
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func testViewDidLoadEqual() {
        view.showError(with: "error")
        XCTAssertEqual(view.msg, "error")
    }
    
    
    func testViewDidLoadNotEqual() {
        view.showError(with: "error")
        XCTAssertNotEqual(view.msg, "erro")
    }
}

class RecipeListVCMock: RecipeListViewProtocol {
    var presenter: RecipeListPresenterProtocol?
    
    var msg = ""
    
    func showIndicator() {
        
    }
    
    func hideIndicator() {
        
    }
    
    func reloadCollection() {
            
    }
    
    func reloadTableView() {
        
    }
    
    func showError(with msg: String) {
        self.msg = msg
    }
    
    func hideError() {
        
    }
}

class RecipeListInteractorMock: RecipeListInteractorProtocol {
    var presenter: RecipeListPresenterProtocol?
    
    var remoteDataManager: RecipeListRemoteDataMangagerProtcol?
    
    func retriveRecipeList(searchText: String?, from: Int, to: Int, filter: String?) {
        
    }
    
    func onRecipesRetrieved(recipeModel: RecipesModel) {
        
    }
    
    func onError(error: FetchError) {
        
    }
    
    func retriveHistory() {
        
    }
    
    func saveHistory(searchText: String) {
        
    }
}

