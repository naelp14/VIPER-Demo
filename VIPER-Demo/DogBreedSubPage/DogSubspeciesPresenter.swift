//
//  DogSubBreedPresenter.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 12/09/23.
//

import Foundation

protocol DogSubspeciesPresenter: AnyObject {
    func openDetailPage(breedSubspecies: String)
}

final class DefaultDogSubspeciesPresenter: DogSubspeciesPresenter {
    let router: DogSubspeciesRouter
    let species: String
    weak var view: DogSubspeciesView?
    
    init(router: DogSubspeciesRouter, species: String) {
        self.router = router
        self.species = species
    }
    
    func openDetailPage(breedSubspecies: String) {
        router.redirectToDetailPage(breedSpecies: species, breedSubspecies: breedSubspecies)
    }
}
