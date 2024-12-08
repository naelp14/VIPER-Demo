//
//  DogBreedImagePageBuilder.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 15/09/23.
//

import Foundation
import UIKit

struct DogBreedImagePageBuilder {
    
    static func build(breedSpecies: String, breedSubspecies: String) -> UIViewController {
        let interactor = DefaultDogImagePageInteractor()
        let presenter = DefaultDogBreedImagePagePresenter(
            interactor: interactor,
            dogBreedSpecies: breedSpecies,
            dogSubBreedSpecies: breedSubspecies
        )
        let view = DefaultDogBreedImagePageView(
            presenter: presenter,
            dogType: "\(breedSpecies) \(breedSubspecies)"
        )
        presenter.view = view
        return view
    }
    
}
