//
//  DetailViewController.swift
//  HooqDemo
//
//  Created by Kajal on 3/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    private enum Layout {
        static let rowHeight: CGFloat = 170
    }

    @IBOutlet weak var backgroundImageView: CustomImageView!
    @IBOutlet weak var movieImageView: CustomImageView!
    @IBOutlet weak var movieDescLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    let loadingScreen: LoadingView
    let manager: DetailViewModel
    var currentMovie: MovieList?
    
    init(viewModel: DetailViewModel, loading: LoadingView, currentMovie: MovieList?) {
        self.currentMovie = currentMovie
        self.manager = viewModel
        self.loadingScreen = loading
        super.init(nibName: GlobalConstants.detailNib, bundle: nil)
    }
    
    convenience init(currentMovie: MovieList?) {
        let networkService = NetworkService()
        let detailView = DetailViewModel(networkService: networkService)
        let loading = LoadingView.newInstance()
        self.init(viewModel: detailView, loading: loading, currentMovie: currentMovie)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        allocateObjects()
    }
    
    // MARK: - Private Methods
    private func setupLayout() {
        navigationController?.navigationBar.isHidden = true
        manager.delegate = self
        detailTableView.register(UINib(nibName: GlobalConstants.tableCellNib, bundle: nil), forCellReuseIdentifier: GlobalConstants.tableCellId)
    }
    
    private func allocateObjects() {
        guard let movie = currentMovie else { return }
        movieNameLabel.text = movie.title
        movieDateLabel.text = movie.date
        movieDescLabel.text = movie.overview
        
        if let id = movie.id {
            manager.loadContentForSimilarMoviesList(id)
        }
        
        guard let poster = movie.path else {
            movieImageView.image = UIImage(named:GlobalConstants.noImage)
            return
        }
        
        let imageString = GlobalConstants.detailImageURL + poster
        movieImageView.loadImageUsingUrlString(imageString)
        backgroundImageView.loadImageUsingUrlString(imageString)
    }
    
}

// MARK: - IBActions
extension DetailViewController {
    @IBAction func closePressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableView Delegates & DataSource
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: GlobalConstants.tableCellId, for: indexPath) as? DetailTableViewCell
        cell?.setupCollectionView(value: manager.similarMovieArray)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Layout.rowHeight
    }
}

//MARK:- DetailViewModelDelegate Protocol Methods
extension DetailViewController: DetailViewModelDelegate {
    private func didUpdateList() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.reloadData()
        
        if let tbHeight = detailTableView.tableHeaderView?.frame.size.height {
            self.detailTableView.tableHeaderView?.frame.size.height = tbHeight + self.movieDescLabel.bounds.size.height
        }
        self.detailTableView.reloadData()
        self.loadingScreen.hide()
    }
    
    func didUpdatePortfoliosState(from oldValue: DetailViewModel.State, newValue: DetailViewModel.State) {
        DispatchQueue.main.async {
            switch newValue {
            case .loading:
                self.loadingScreen.show()
            case .success:
                self.didUpdateList()
            case .error(let error):
                self.showAlertPopUp(message: error.localizedDescription)
                self.loadingScreen.hide()
            }
        }
    }
}

//MARK:- DetailTableViewCellDelegate Protocol Methods
extension DetailViewController: DetailTableViewCellDelegate {
    func didNavigate(value: MovieList?) {
        let detailViewController = DetailViewController(currentMovie: value)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
