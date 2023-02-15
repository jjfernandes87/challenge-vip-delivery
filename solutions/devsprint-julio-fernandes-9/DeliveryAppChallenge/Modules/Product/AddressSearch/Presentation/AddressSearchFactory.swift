//
//  AddressSearchFactory.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 11/02/23.
//

import UIKit

enum AddressSearchControllerFactory {

    static func make() -> AddressSearchViewController {
        let addressListView = AddressListView()
        let presenter = AddressSearchPresenter()
        let remoteLoader = RemoteAddressSearchLoader(networking: NetworkManager())
        let locaLoader = LocalAddressSearchLoader()
        
        // Composite para tratamento de retry
        let loaderComposite = AddressSearchComposite(main: remoteLoader, fallback: remoteLoader)
        
        // Decorator para extender a ação de loading e gravar os dados locais
        let loaderDecorator = AddressSearchDecorator(decoratee: loaderComposite, localLoader: locaLoader)
        
        let interactor = AddressSearchInteractor(presenter: presenter, remoteLoader: loaderDecorator, localLoader: locaLoader)
        let controller = AddressSearchViewController(addresslistView: addressListView, interactor: interactor)
        presenter.controller = controller

        return controller
    }

}
