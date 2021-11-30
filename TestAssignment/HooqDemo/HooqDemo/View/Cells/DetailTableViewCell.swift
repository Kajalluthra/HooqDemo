//
//  DetailTableViewCell.swift
//  HooqDemo
//
//  Created by Kajal on 3/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import UIKit

protocol DetailTableViewCellDelegate: class {
    func didNavigate(value: MovieList?)
}

final class DetailTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    private enum Layout {
        static let collectionCellSize = CGSize(width: 110, height: 132)
    }

    @IBOutlet private weak var similarLabel: UILabel!
    @IBOutlet private weak var similarMovieCollectionView: UICollectionView!
    weak var delegate: DetailTableViewCellDelegate?
    
    private var similarMoviesArray: [MovieList] = [MovieList]()
     
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        similarMovieCollectionView.setCollectionViewLayout(layout, animated: true)
        let cellNib = UINib(nibName: GlobalConstants.collectionCellNib, bundle: nil)
        similarMovieCollectionView.register(cellNib, forCellWithReuseIdentifier: GlobalConstants.collectionCellId)
        
        similarMovieCollectionView.dataSource = self
        similarMovieCollectionView.delegate = self
    }
    
    func setupCollectionView(value : [MovieList]) {
        if value.isEmpty {
            similarLabel.isHidden = true
            return
        }
        similarMoviesArray = value
        similarMovieCollectionView.reloadData()
    }
}

// MARK:- Collection View
extension DetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlobalConstants.collectionCellId, for: indexPath) as? DetailCollectionViewCell
        cell?.setupCellData(similarMoviesArray[indexPath.row])
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Layout.collectionCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didNavigate(value: similarMoviesArray[indexPath.row])
    }
}
