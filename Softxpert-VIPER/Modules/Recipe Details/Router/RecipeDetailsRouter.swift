//
//  RecipeDetailsRouter.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 29/10/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RecipeDetailsRouterProtocol: AnyObject {
    static func start(recipe: Recipe) -> UIViewController
    var viewController: UIViewController? { get set }
}

class RecipeDetailsRouter: RecipeDetailsRouterProtocol {
    var viewController: UIViewController?
        
    static func start(recipe: Recipe) -> UIViewController {
        if let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsVC") as? RecipeDetailsVC {
            
            let router = RecipeDetailsRouter()
            let interactor = RecipeDetailsInteractor()
            let presenter = RecipeDetailsPresenter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.recipe = recipe
            presenter.interactor = interactor
            presenter.router = router
            interactor.presenter = presenter
            router.viewController = view
            return view
        }
        return UIViewController()
    }
}

