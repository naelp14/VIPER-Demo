//
//  FavouritesDetailPagePresenter.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 15/09/23.
//

import Foundation

final class FavouritesDetailPagePresenter: DefaultDogBreedImagePagePresenter {
    
    override func fetchImage(completion: @escaping (([DogBreedModel]) -> ())) {
        loadDict()
        let key = "\(dogBreedSpecies) \(dogSubBreedSpecies)"
        completion(favBreedList[key] ?? [])
    }
    
}
