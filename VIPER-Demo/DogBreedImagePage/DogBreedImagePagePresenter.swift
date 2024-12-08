//
//  DogBreedImagePagePresenter.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 14/09/23.
//

import Foundation
import UIKit

protocol DogBreedImagePagePresenter {
    func fetchImage(completion: @escaping(([DogBreedModel]) -> ()))
    func likeImage(model: DogBreedModel)
    func updateFavList()
}

class DefaultDogBreedImagePagePresenter: DogBreedImagePagePresenter {

    let interactor: DogBreedImagePageInteractor
    let dogBreedSpecies: String
    let dogSubBreedSpecies: String
    var favBreedList: [String: [DogBreedModel]] = [:]
    weak var view: DogBreedImagePageView?
    
    init(
        interactor: DogBreedImagePageInteractor,
        dogBreedSpecies: String,
        dogSubBreedSpecies: String
    ) {
        self.interactor = interactor
        self.dogBreedSpecies = dogBreedSpecies
        self.dogSubBreedSpecies = dogSubBreedSpecies
    }
    
    func fetchImage(completion: @escaping(([DogBreedModel]) -> ())) {
        loadDict()
        let key = "\(dogBreedSpecies) \(dogSubBreedSpecies)"
        var dogBreedList: [DogBreedModel] = []
        interactor.fetchDogImages(
            breedSpecies: dogBreedSpecies,
            subSpecies: dogSubBreedSpecies) { imageUrls in
                for urlString in imageUrls {
                    if let url = URL(string: urlString),
                       let imageData = try? Data(contentsOf: url) {
                        let model = DogBreedModel(imageUrl: urlString, image: imageData, isLiked: false)
                        if self.favBreedList[key]?.contains(DogBreedModel(imageUrl: urlString, image: imageData, isLiked: true)) == true {
                            model.isLiked = true
                        }
                        dogBreedList.append(model)
                    }
                }
                completion(dogBreedList)
            }
    }
    
    func likeImage(model: DogBreedModel) {
        let key = "\(dogBreedSpecies) \(dogSubBreedSpecies)"
        if model.isLiked {
            if favBreedList.keys.contains(key) {
                favBreedList[key]?.append(model)
            } else {
                favBreedList[key] = [model]
            }
        } else {
            favBreedList[key]?.removeAll(where: { $0 == model })
            if favBreedList[key]?.isEmpty == true {
                favBreedList.removeValue(forKey: key)
            }
        }
    }
    
    func updateFavList() {
        let data = try? JSONEncoder().encode(favBreedList)
        UserDefaults.standard.set(data, forKey: "favBreed")
    }
    
    func loadDict() {
        if let data = UserDefaults.standard.data(forKey: "favBreed"),
           let list = try? JSONDecoder().decode([String: [DogBreedModel]].self, from: data) {
            favBreedList = list
        }
    }
}
    

