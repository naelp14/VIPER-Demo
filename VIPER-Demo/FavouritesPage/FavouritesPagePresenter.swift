//
//  FavouritesPagePresenter.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 15/09/23.
//

import Foundation

protocol FavouritesPagePresenter {
    func openDetailPage(breedSubspecies: String)
    func fetchData()
}

final class DefaultFavouritesPagePresenter: FavouritesPagePresenter {
    
    let router: FavouritesPageRouter
    weak var view: FavouritesPageView?
    
    init(router: FavouritesPageRouter) {
        self.router = router
    }
    
    func openDetailPage(breedSubspecies: String) {
        var nameArray = breedSubspecies.split(separator: " ")
        if nameArray.count == 1 {
            nameArray.append("")
        }
        router.redirectToDetailPage(breedSpecies: String(nameArray[0]), breedSubspecies: String(nameArray[1]))
    }
    
    func fetchData() {
        if let data = UserDefaults.standard.data(forKey: "favBreed"),
           let list = try? JSONDecoder().decode([String: [DogBreedModel]].self, from: data) {
            view?.reloadTable(list: Array(list.keys))
        }
    }
    
}
