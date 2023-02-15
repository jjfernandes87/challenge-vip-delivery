//
//  AddressSearchComposite.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 15/02/23.
//

import Foundation

final class AddressSearchComposite {
    
    let main: AddressSearchLoader
    let fallback: AddressSearchLoader
    
    init(main: AddressSearchLoader, fallback: AddressSearchLoader) {
        self.main = main
        self.fallback = fallback
    }
    
}

extension AddressSearchComposite: AddressSearchLoader {
    func doRequest(completion: @escaping (Result<[AddressListViewModel], Error>) -> Void) {
        main.doRequest { [weak self] result in
            switch result {
            case let .success(items): completion(.success(items))
            case .failure: self?.fallback.doRequest(completion: completion)
            }
        }
    }
}
