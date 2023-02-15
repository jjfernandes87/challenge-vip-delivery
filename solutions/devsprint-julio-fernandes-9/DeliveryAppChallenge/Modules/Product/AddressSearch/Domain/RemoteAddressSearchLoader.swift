//
//  RemoteAddressSearchLoader.swift
//  DeliveryApp
//
//  Created by Julio Fernandes on 15/02/23.
//

import Foundation

enum AddressNetworkRequest: NetworkRequest {
    
    case fetchDataView
    
    var pathURL: String {
        return "address_search_results.json"
    }
    
    var method: HTTPMethod {
        .get
    }
}

struct AddressListViewModel: Codable {
    let street: String
    let number: String
    let neighborhood: String
}


protocol AddressSearchLoader {
    func doRequest(completion: @escaping (Result<[AddressListViewModel], Error>) -> Void)
}

final class RemoteAddressSearchLoader: AddressSearchLoader {
    
    let networking: NetworkManagerProtocol
    init(networking: NetworkManagerProtocol) {
        self.networking = networking
    }
    
    func doRequest(completion: @escaping (Result<[AddressListViewModel], Error>) -> Void) {
        networking.request(AddressNetworkRequest.fetchDataView, completion: completion)
    }
    
}
