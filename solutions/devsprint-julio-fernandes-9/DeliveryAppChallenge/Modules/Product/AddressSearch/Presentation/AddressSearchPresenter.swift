//
//  AddressSearchPresenter.swift
//  DeliveryAppChallenge
//
//  Created by Renato F. dos Santos Jr on 10/02/23.
//

import Foundation

protocol AddressSearchPresenterProtocol: AnyObject {
    var controller: AddressSearchViewControllerProtocol? { get set }
    func presentResponse(_ response: AddressSearch.Response)
}

final class AddressSearchPresenter: AddressSearchPresenterProtocol {
    
    weak var controller: AddressSearchViewControllerProtocol?

    func presentResponse(_ response: AddressSearch.Response) {
        switch response {
        case let .hasDataView(response): controller?.displayViewModel(.dataView(viewEntity: response))
        case let .errorFetchDataView(message): controller?.displayViewModel(.dataViewWithError(message: message))
        }
    }
    
}
