//
//  FavouritesDetailPageBuilder.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 15/09/23.
//

import UIKit
import Foundation

struct FavouritesDetailPageBuilder {
    static func build(dogBreedSpecies: String, dogBreedSubspecies: String) -> UIViewController {
        let interactor = DefaultDogImagePageInteractor()
        let presenter = FavouritesDetailPagePresenter(interactor: interactor, dogBreedSpecies: dogBreedSpecies, dogSubBreedSpecies: dogBreedSubspecies)
        let view = DefaultDogBreedImagePageView(presenter: presenter, dogType: "\(dogBreedSpecies) \(dogBreedSubspecies)")
        presenter.view = view
        return view
    }
}
