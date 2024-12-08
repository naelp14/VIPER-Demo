//
//  HomePresenter.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 11/09/23.
//

import Foundation
import UIKit

protocol HomePresenter {
    func fetchBreedList()
    func redirectToDetailPage(key: String, values: [String])
}

final class DefaultHomePresenter: HomePresenter {
    let interactor: HomeInteractor
    let router: HomeRouter
    weak var view: HomeView?
    
    init(interactor: HomeInteractor, router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func fetchBreedList() {
        interactor.fetchBreedList()
    }
    
    func redirectToDetailPage(key: String, values: [String]) {
        if values.isEmpty {
            router.openDetailPage(breedSpecies: key, breedSubspecies: "")
        } else {
            router.openSubSpeciesPage(breedSpecies: key, breedSubspecies: values)
        }
    }
}

extension DefaultHomePresenter: HomeInteractorDelegate {
    func handleError() {
        // handle API error here
    }
    
    func processData(list: [String: [String]]) {
        view?.showListOfBreeds(list: list)
    }
}
