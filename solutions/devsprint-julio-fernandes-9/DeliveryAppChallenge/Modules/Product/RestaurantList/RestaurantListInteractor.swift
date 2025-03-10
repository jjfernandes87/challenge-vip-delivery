//
//  RestaurantListInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Cora on 07/02/23.
//

import Foundation

protocol RestaurantListInteractorProtocol {
    
}

final class RestaurantListInteractor: RestaurantListInteractorProtocol {
    
    private let presenter: RestaurantListPresenterProtocol
    
    init(presenter: RestaurantListPresenterProtocol) {
        self.presenter = presenter
    }
}
