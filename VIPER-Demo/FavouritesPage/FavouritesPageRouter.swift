//
//  FavouritesPageRouter.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 15/09/23.
//

import Foundation
import UIKit

protocol FavouritesPageRouter {
    func redirectToDetailPage(breedSpecies: String, breedSubspecies: String)
}

final class DefaultFavouritesPageRouter: FavouritesPageRouter {
    let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func redirectToDetailPage(breedSpecies: String, breedSubspecies: String) {
        let imagePage = FavouritesDetailPageBuilder.build(
            dogBreedSpecies: breedSpecies,
            dogBreedSubspecies: breedSubspecies
        )
        navigation.pushViewController(imagePage, animated: true)
    }
    
}
