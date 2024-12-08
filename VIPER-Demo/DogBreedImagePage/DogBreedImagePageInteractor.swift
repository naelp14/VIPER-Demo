//
//  DogBreedImagePageInteractor.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 15/09/23.
//

import Foundation

protocol DogBreedImagePageInteractor {
    func fetchDogImages(breedSpecies: String, subSpecies: String, completion: @escaping(([String])->()))
}

final class DefaultDogImagePageInteractor: DogBreedImagePageInteractor {
    
    func fetchDogImages(
        breedSpecies: String,
        subSpecies: String,
        completion: @escaping(([String])->()))
    {
        let session = URLDataSessionHelper()
        let endpoint = constructEndpoint(breedSpecies: breedSpecies, subSpecies: subSpecies)
        session.hitAPI(
            endpoint: endpoint,
            httpMethod: "GET",
            dataType: [String].self
        ) { (data, error) in
            if let list = data {
                completion(list)
            }
        }
    }
    
    private func constructEndpoint(breedSpecies: String, subSpecies: String) -> String {
        var endpoint = "https://dog.ceo/api/breed/\(breedSpecies)"
        if !subSpecies.isEmpty {
            endpoint.append("/\(subSpecies)")
        }
        endpoint.append("/images")
        return endpoint
    }
    
}
