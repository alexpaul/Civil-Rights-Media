//
//  ViewController.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/17/21.
//

import UIKit
import Kingfisher

final class MoviesViewController: BaseViewController {
  
  private let apiClient = APIClient<MovieWrapper>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureDataSource()
    fetchMovies()
    refreshControl.addTarget(self, action: #selector(fetchMovies), for: .valueChanged)
  }
  
  @objc
  private func fetchMovies() {
    apiClient.fetchMediaItems { [weak self] (result) in
      switch result {
      case .failure(let error):
        print(error)
      case .success(let items):
        let movies = items.movies.map { $0.value }
        self?.updateSnapshot(with: movies)
        DispatchQueue.main.async {
          self?.refreshControl.endRefreshing()
        }
      }
    }
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Int, AnyHashable>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {
        fatalError("could not dequeue a MovieCell")
      }
      let movie = movie as! Movie
      cell.backgroundColor = .systemBackground
      cell.imageView.kf.setImage(with: URL(string: movie.imageURL))
      cell.overviewLabel.text = movie.overview
      return cell
    })
    
    dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
      guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
        fatalError("could not dequeue a HeaderView")
      }
      return headerView
    }
  }
}

