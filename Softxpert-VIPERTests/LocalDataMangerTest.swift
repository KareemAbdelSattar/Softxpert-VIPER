//
//  LocalDataMangerTest.swift
//  Softxpert-VIPERTests
//
//  Created by kareem chetoos on 31/10/2022.
//

import XCTest
@testable import Softxpert_VIPER

class LocalDataMangerTest: XCTestCase {

    var localDataManger = RecipeListLocalDataManager()
    
    override func setUp() {
        super.setUp()
    }
    
    func testSaveDataInLocal(){
       try! localDataManger.saveHistory(searchText: "Kareem")
        let firstSearch = try! localDataManger.retrieveHistory().first
        
        XCTAssert(firstSearch?.suggestion == "Kareem", "should return nil when there's no user saved")
    }
}
