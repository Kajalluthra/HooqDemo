//
//  HomeViewController.swift
//  HooqDemo
//
//  Created by Kajal on 1/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    private enum Layout {
        static let itemConstant: CGFloat = 45
    }
    @IBOutlet weak var movieCollectionView: UICollectionView!
    let viewModel: HomeViewModel
    let loading: LoadingView
    let networkService = NetworkService()
    
    init(viewModel: HomeViewModel, loading: LoadingView) {
        self.viewModel = HomeViewModel(networkService: networkService)
        self.loading = loading
        super.init(nibName: GlobalConstants.homeNib, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private Methods
    private func setupLayout() {
        title = GlobalConstants.appName
        viewModel.delegate = self
        
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        let cellNib = UINib(nibName: GlobalConstants.collectionCellNib, bundle: nil)
        movieCollectionView.register(cellNib, forCellWithReuseIdentifier: GlobalConstants.collectionCellId)
    }
}

// MARK: - UICollectionView Delegates & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobalConstants.collectionCellId, for: indexPath) as? DetailCollectionViewCell
        cell?.setupCellData(viewModel.movieListArray[indexPath.row])
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.movieListArray.count - 1) {
            viewModel.fetchMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width/3.0)-1
        let yourHeight = yourWidth+Layout.itemConstant
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailViewModel(networkService: networkService)
        let detailViewController = DetailViewController(viewModel: detailView,
                                                        loading: loading,
                                                        currentMovie: viewModel.movieListArray[indexPath.row])
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK:- HomeViewModelDelegate Protocol Methods
extension HomeViewController : HomeViewModelDelegate {
    func didUpdatePortfoliosState(from oldValue: HomeViewModel.State, newValue: HomeViewModel.State) {
        DispatchQueue.main.async {
            switch newValue {
            case .loading:
                self.loading.show()
            case .success:
                self.movieCollectionView.reloadData()
                self.loading.hide()
            case .error(let error):
                self.showAlertPopUp(message: error.localizedDescription)
                self.loading.hide()
            }
        }
    }
}



