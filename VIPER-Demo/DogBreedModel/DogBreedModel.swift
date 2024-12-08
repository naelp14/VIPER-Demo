//
//  DogBreedModel.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 15/09/23.
//

import Foundation
import UIKit

class DogBreedModel: Equatable, Codable {
    var imageUrl: String
    var image: Data
    var isLiked: Bool
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl
        case image
        case isLiked
    }
    
    init(imageUrl: String, image: Data, isLiked: Bool) {
        self.imageUrl = imageUrl
        self.image = image
        self.isLiked = isLiked
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decode(Data.self, forKey: .image)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        isLiked = try values.decode(Bool.self, forKey: .isLiked)
    }
    
    static func == (lhs: DogBreedModel, rhs: DogBreedModel) -> Bool {
        return (lhs.image == rhs.image && lhs.isLiked == rhs.isLiked && lhs.imageUrl == rhs.imageUrl)
    }
}
