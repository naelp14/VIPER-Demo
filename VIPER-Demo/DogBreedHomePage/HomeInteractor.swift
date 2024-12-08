//
//  HomeInteractor.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 11/09/23.
//

import Foundation

protocol HomeInteractor {
    func fetchBreedList()
}

protocol HomeInteractorDelegate: AnyObject {
    func processData(list: [String: [String]])
    func handleError()
}

final class DefaultHomeInteractor: HomeInteractor {
    weak var delegate: HomeInteractorDelegate?
    
    func fetchBreedList() {
        let session = URLDataSessionHelper()
        session.hitAPI(
            endpoint: "https://dog.ceo/api/breeds/list/all",
            httpMethod: "GET",
            dataType: [String: [String]].self
        ) { [weak self] (data, error) in
            if let list = data {
                self?.delegate?.processData(list: list)
            } else {
                self?.delegate?.handleError()
            }
        }
    }
}
