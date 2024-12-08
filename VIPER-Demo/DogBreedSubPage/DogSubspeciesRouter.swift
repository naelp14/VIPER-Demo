//
//  DogSubBreedRouter.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 12/09/23.
//

import Foundation
import UIKit

protocol DogSubspeciesRouter: AnyObject {
    func redirectToDetailPage(breedSpecies: String, breedSubspecies: String)
}

final class DefaultDogSubspeciesRouter: DogSubspeciesRouter {
    let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func redirectToDetailPage(breedSpecies: String, breedSubspecies: String) {
        let imagePage = DogBreedImagePageBuilder.build(
            breedSpecies: breedSpecies,
            breedSubspecies: breedSubspecies
        )
        navigation.pushViewController(imagePage, animated: true)
    }
    
}
