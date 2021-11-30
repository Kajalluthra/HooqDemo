//
//  DetailViewModel.swift
//  HooqDemo
//
//  Created by Kajal on 3/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import UIKit

protocol DetailViewModelDelegate: AnyObject {
    func didUpdatePortfoliosState(from oldValue: DetailViewModel.State,
                                 newValue: DetailViewModel.State)
}

class DetailViewModel: NSObject {
    weak var delegate: DetailViewModelDelegate?
    let apiInstance: NetworkService
    
    var similarMovieArray:[MovieList] = [MovieList]()
    enum State {
        case loading
        case success
        case error(_ error: Error)
    }
    
    var state: State = DetailViewModel.State.loading {
        didSet { delegate?.didUpdatePortfoliosState(from: oldValue, newValue: state) }
    }
    
    init(networkService: NetworkService) {
        self.apiInstance = networkService
        super.init()
    }
    
    func loadContentForSimilarMoviesList(_ id: Int) {
        state = .loading
        apiInstance.fetchSimilarMoviesApiRequest(id) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let response):
                strongSelf.similarMovieArray.append(contentsOf: response.movies)
                strongSelf.state = .success
            case .failure(let error):
                strongSelf.state = .error(error)
            }
        }
    }
}
