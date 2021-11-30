
//
//  HomeViewModelTests.swift
//  HooqDemoTests
//
//  Created by Kajal on 1/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import XCTest
@testable import HooqDemo

class HomeViewModelTests: XCTestCase {
    func test_homeViewModel() {
        let networkService = MockService()
        let sut = HomeViewModel(networkService: networkService)
        networkService.response = .success(Results.dummy)
        sut.loadContentForMoviesList()
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.movieListArray)
        XCTAssertEqual(sut.movieListArray.count, 2)
        XCTAssertEqual(sut.movieListArray[0].title, "Test")
        XCTAssertEqual(sut.movieListArray[0].id, 1)
        XCTAssertEqual(sut.movieListArray[0].path, "abc.com")
        XCTAssertEqual(sut.movieListArray[1].title, "Rest")
        XCTAssertEqual(sut.movieListArray[1].id, 2)
        XCTAssertEqual(sut.movieListArray[1].path, "def.com")
    }
}

class MockService: NetworkService {
    var response: Result<Results, Error>?
    override func fetchAllMoviesApiRequest(_ pagelimit: Int, completion: @escaping (Result<Results, Error>) -> Void) {
        guard let result = response else { return }
        completion(result)
    }
}

extension Results {
    static var dummy: Results {
        let movieTest = MovieList(title: "Test", id: 1, path: "abc.com", overview: "test test test", date: nil)
        let movieRest = MovieList(title: "Rest", id: 2, path: "def.com", overview: "rest rest rest", date: nil)
        return Results(movies: [movieTest, movieRest], count: 5)
    }
}
