//
//  LocalAddressSearchLoader.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 15/02/23.
//

import Foundation

protocol LocalAddressSearch: AddressSearchLoader {
    func insert(items: [AddressListViewModel])
    func filterBy(_ filter: String, completion: @escaping ([AddressListViewModel]) -> Void)
}


final class LocalAddressSearchLoader: LocalAddressSearch {
    
    private var items: [AddressListViewModel] = []
    
    func insert(items: [AddressListViewModel]) {
        self.items = items
    }
    
    func filterBy(_ filter: String, completion: @escaping ([AddressListViewModel]) -> Void) {
        let items = items.filter { $0.street.contains(filter) }
        completion(items)
    }
    
    func doRequest(completion: @escaping (Result<[AddressListViewModel], Error>) -> Void) {
        completion(.success(items))
    }
}
