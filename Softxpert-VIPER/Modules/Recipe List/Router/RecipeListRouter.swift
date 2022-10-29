//
//  RecipeListRouter.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 27/10/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RecipeListRouterProtocol: AnyObject {
    static func start() -> UIViewController
    var viewController: UIViewController? { get set }
    func pushToRecipeDetails(recipe: Recipe)
}

class RecipeListRouter: RecipeListRouterProtocol {
    var viewController: UIViewController?
        
    static func start() -> UIViewController {
        if let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeListVC") as? RecipeListVC {
            let nv = UINavigationController(rootViewController: view)
            let router = RecipeListRouter()
            let interactor = RecipeListInteractor()
            let presenter = RecipeListPresenter()
            let remoteDataManager = RecipeListRemoteDataMangager()
            let localDataManager = RecipeListLocalDataManager()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            interactor.localDataManager = localDataManager
            remoteDataManager.interactor = interactor
            router.viewController = view
            return nv
        }
        return UIViewController()
    }
    
    func pushToRecipeDetails(recipe: Recipe) {
        let recipeDetailsVC = RecipeDetailsRouter.start(recipe: recipe)
        
        if let sourceView = viewController as? RecipeListVC {
            sourceView.navigationController?.pushViewController(recipeDetailsVC, animated: true)
        }
    }
}

