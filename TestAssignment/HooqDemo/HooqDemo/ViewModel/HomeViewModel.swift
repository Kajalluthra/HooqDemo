//
//  HomeViewModel.swift
//  HooqDemo
//
//  Created by Kajal on 1/3/2010.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func didUpdatePortfoliosState(from oldValue: HomeViewModel.State,
                                 newValue: HomeViewModel.State)
}

class HomeViewModel: NSObject {
    weak var delegate: HomeViewModelDelegate?
    let apiInstance: NetworkService
    var movieListArray:[MovieList] = [MovieList]()
    
    var pageNo: Int = 1
    var totalPages: Int = 0
    
    enum State {
        case loading
        case success
        case error(_ error: Error)
    }
    
    var state: State = HomeViewModel.State.loading {
        didSet { delegate?.didUpdatePortfoliosState(from: oldValue, newValue: state) }
    }
    
    init(networkService: NetworkService) {
        self.apiInstance = networkService
        super.init()
        state = .loading
        loadContentForMoviesList()
    }
    
    func fetchMore () {
        if pageNo < totalPages {
            pageNo += 1
            loadContentForMoviesList()
        }
    }
    
    func loadContentForMoviesList() {
        apiInstance.fetchAllMoviesApiRequest(pageNo) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let response):
                strongSelf.totalPages = response.count
                strongSelf.movieListArray.append(contentsOf: response.movies)
                strongSelf.state = .success
            case .failure(let error):
                strongSelf.state = .error(error)
            }
        }
    }
}
