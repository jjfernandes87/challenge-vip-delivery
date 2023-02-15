//
//  AddressSearchInteractor.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 10/02/23.
//

import Foundation

enum AddressSearch {
    
    enum Request {
        case fetchDataView
        case filterBy(filter: String)
    }
    
    enum Response {
        case hasDataView(response: [AddressListViewModel])
        case errorFetchDataView(message: String)
    }

    enum ViewModel {
        case dataView(viewEntity: [AddressListViewModel])
        case dataViewWithError(message: String)
    }
//
//    enum Route {
//        case dismissHomeScene
//        case goToSettings
//        case showMessageError(message: String)
//        case goToRestaurantDetail
//        case goToEditAddress
//    }
}


protocol AddressSearchInteractorProtocol: AnyObject {
    func doRequest(_ request: AddressSearch.Request)
}

final class AddressSearchInteractor: AddressSearchInteractorProtocol {
    
    let presenter: AddressSearchPresenterProtocol
    let remoteLoader: AddressSearchLoader
    let localLoader: LocalAddressSearch
    
    init(presenter: AddressSearchPresenterProtocol, remoteLoader: AddressSearchLoader, localLoader: LocalAddressSearch) {
        self.presenter = presenter
        self.remoteLoader = remoteLoader
        self.localLoader = localLoader
    }
    
    func doRequest(_ request: AddressSearch.Request) {
        switch request {
        case .fetchDataView: fetchRemoteLoader()
        case let .filterBy(value): fetchData(by: value)
        }
    }
    
    private func fetchRemoteLoader() {
        remoteLoader.doRequest { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items): self.presenter.presentResponse(.hasDataView(response: items))
            case .failure: self.presenter.presentResponse(.errorFetchDataView(message: "Error ao buscar dados locais"))
            }
        }
    }
    
    private func fetchData(by filter: String) {
        localLoader.filterBy(filter) { [weak self] items in
            guard let self = self else { return }
            self.presenter.presentResponse(.hasDataView(response: items))
        }
    }

}
