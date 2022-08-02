//
//  HomeViewRepositoryTests.swift
//  DeliveryAppChallengeTests
//
//  Created by Julio Fernandes on 01/08/22.
//

import XCTest
@testable import DeliveryApp

final class HomeViewRepositoryTests: XCTestCase {
    
    private lazy var network: NetworkManagerProtocolSpy = NetworkManagerProtocolSpy()
    private var sut: HomeViewRepository?

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HomeViewRepository(network: network)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_should_call_fetchData() {
        sut?.fetchData(completion: { _ in })
        XCTAssertTrue(network.requestCalled)
    }

}

final class NetworkManagerProtocolSpy: NetworkManagerProtocol {
    
    private(set) var requestCalled = false
    func request<T>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>) where T : Decodable {
        requestCalled = true
    }

}
