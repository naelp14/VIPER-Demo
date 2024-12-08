//
//  FavouritesPageBuilder.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 15/09/23.
//

import UIKit
import Foundation

struct FavouritesPageBuilder {
    static func build(navigation: UINavigationController) -> UIViewController {
        let router = DefaultFavouritesPageRouter(navigation: navigation)
        let presenter = DefaultFavouritesPagePresenter(router: router)
        let view = DefaultFavouritesPageView(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
