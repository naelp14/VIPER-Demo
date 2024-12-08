//
//  HomeBuilder.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 11/09/23.
//

import Foundation
import UIKit

struct HomeBuilder {
    
    static func build(navigationController: UINavigationController) -> UIViewController {
        let interactor = DefaultHomeInteractor()
        let router = DefaultHomeRouter(navigation: navigationController)
        let presenter = DefaultHomePresenter(
            interactor: interactor,
            router: router
        )
        let view = DefaultHomeView(presenter: presenter)
        interactor.delegate = presenter
        presenter.view = view
        return view
    }
    
}
