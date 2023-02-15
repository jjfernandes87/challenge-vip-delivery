//
//  AddressSearchViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

protocol AddressSearchViewControllerProtocol where Self: UIViewController {
    func displayViewModel(_ viewModel: AddressSearch.ViewModel)
}

final class AddressSearchViewController: UIViewController, AddressSearchViewControllerProtocol {
    
    // TODO: Should one inject such dependency?
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - UI Properties
    private let addresslistView: AddressListViewProtocol

    // MARK: - VIP Lifecycle dependencies
    private let interactor: AddressSearchInteractorProtocol

    init(addresslistView: AddressListViewProtocol, interactor: AddressSearchInteractorProtocol) {
        self.addresslistView = addresslistView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func loadView() {
        super.loadView()
        self.view = addresslistView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        interactor.doRequest(.fetchDataView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDelegatesAndNavigation()
    }
    
    func displayViewModel(_ viewModel: AddressSearch.ViewModel) {
        switch viewModel {
        case let .dataView(viewEntity):
            DispatchQueue.main.async { [weak self] in
                self?.addresslistView.show(viewModelList: viewEntity)
            }
        case let .dataViewWithError(message): print(message)
        }
    }
    
}

extension AddressSearchViewController {
    private func setupDelegatesAndNavigation() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Rua, número, bairro"
        searchController.searchBar.delegate = self

        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.title = "Address Search"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension AddressSearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count >= 3 {
            interactor.doRequest(.filterBy(filter: text))
        }
    }
}

extension AddressSearchViewController: UISearchBarDelegate, UISearchControllerDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing: \(searchBar.text)")
    }
}
