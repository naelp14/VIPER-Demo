//
//  HomeRouter.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 11/09/23.
//

import Foundation
import UIKit

protocol HomeRouter {
    func openDetailPage(breedSpecies: String, breedSubspecies: String)
    func openSubSpeciesPage(breedSpecies: String, breedSubspecies: [String])
    func openFavouritesPage()
}

final class DefaultHomeRouter: HomeRouter {
    let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func openSubSpeciesPage(breedSpecies: String, breedSubspecies: [String]) {
        let subSpeciesPage = DogSubspeciesBuilder.build(
            navigationController: navigation,
            breedSpecies: breedSpecies,
            listOfBreedSubSpecies: breedSubspecies
        )
        navigation.pushViewController(subSpeciesPage, animated: true)
    }
    
    func openDetailPage(breedSpecies: String, breedSubspecies: String) {
        let imagePage = DogBreedImagePageBuilder.build(
            breedSpecies: breedSpecies,
            breedSubspecies: breedSubspecies
        )
        navigation.pushViewController(imagePage, animated: true)
    }
    
    func openFavouritesPage() {
        
    }
    
}


