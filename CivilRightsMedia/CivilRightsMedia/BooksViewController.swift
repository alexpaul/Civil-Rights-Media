//
//  BooksViewController.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/18/21.
//

import UIKit
import Kingfisher

final class BooksViewController: BaseViewController {
  
  private let apiClient = APIClient<BookWrapper>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureDataSource()
    fetchBooks()
    refreshControl.addTarget(self, action: #selector(fetchBooks), for: .valueChanged)
  }
  
  @objc
  private func fetchBooks() {
    apiClient.fetchMediaItems { [weak self] (result) in
      switch result {
      case .failure(let error):
        print(error)
      case .success(let items):
        let movies = items.books.map { $0.value }
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
      let movie = movie as! Book
      cell.backgroundColor = .systemBackground
      cell.imageView.kf.setImage(with: URL(string: movie.thumbnail))
      cell.overviewLabel.text = movie.description
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
