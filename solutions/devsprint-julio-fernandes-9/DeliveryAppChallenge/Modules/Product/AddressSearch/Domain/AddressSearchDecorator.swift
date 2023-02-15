//
//  AddressSearchDecorator.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 15/02/23.
//

import Foundation

final class AddressSearchDecorator {
    
    let decoratee: AddressSearchLoader
    let localLoader: LocalAddressSearch
    
    init(decoratee: AddressSearchLoader, localLoader: LocalAddressSearch) {
        self.decoratee = decoratee
        self.localLoader = localLoader
    }
    
}

extension AddressSearchDecorator: AddressSearchLoader {
    
    func doRequest(completion: @escaping (Result<[AddressListViewModel], Error>) -> Void) {
        decoratee.doRequest { [weak self] result in
            switch result {
            case let .success(items):
                self?.localLoader.insert(items: items)
                completion(.success(items))
            default: completion(result)
            }
        }
    }
    
}
