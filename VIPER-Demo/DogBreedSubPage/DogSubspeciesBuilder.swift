//
//  DogSubBreedBuilder.swift
//  ShapeInterviewTest
//
//  Created by Nathaniel Putera on 12/09/23.
//

import Foundation
import UIKit

struct DogSubspeciesBuilder {
    
    static func build(
        navigationController: UINavigationController,
        breedSpecies: String,
        listOfBreedSubSpecies: [String]
    ) -> UIViewController {
        let router = DefaultDogSubspeciesRouter(navigation: navigationController)
        let presenter = DefaultDogSubspeciesPresenter(router: router, species: breedSpecies)
        let view = DefaultDogSubspeciesView(presenter: presenter, listOfSubspecies: listOfBreedSubSpecies)
        presenter.view = view
        return view
    }
    
}
