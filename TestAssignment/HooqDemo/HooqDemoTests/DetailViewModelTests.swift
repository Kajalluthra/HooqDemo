
//
//  DetailViewModelTests.swift
//  HooqDemoTests
//
//  Created by Kajal on 1/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import XCTest
@testable import HooqDemo

class DetailViewModelTests: XCTestCase {
    func test_homeViewModel() {
        let networkService = MockDetailService()
        let sut = DetailViewModel(networkService: networkService)
        networkService.response = .success(Results.dummy)
        sut.loadContentForSimilarMoviesList(2)
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.similarMovieArray)
        XCTAssertEqual(sut.similarMovieArray.count, 2)
        XCTAssertEqual(sut.similarMovieArray[0].title, "Test")
        XCTAssertEqual(sut.similarMovieArray[0].id, 1)
        XCTAssertEqual(sut.similarMovieArray[0].path, "abc.com")
        XCTAssertEqual(sut.similarMovieArray[1].title, "Rest")
        XCTAssertEqual(sut.similarMovieArray[1].id, 2)
        XCTAssertEqual(sut.similarMovieArray[1].path, "def.com")
    }
}

class MockDetailService: NetworkService {
    var response: Result<Results, Error>?
    override func fetchSimilarMoviesApiRequest(_ id: Int, completion: @escaping (Result<Results, Error>) -> Void) {
        guard let result = response else { return }
        completion(result)
    }
}
