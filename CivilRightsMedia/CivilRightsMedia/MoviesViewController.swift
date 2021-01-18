//
//  ViewController.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/17/21.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import Kingfisher

class MoviesViewController: UIViewController {
  
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Int, Movie>!
  private var refreshControl: UIRefreshControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureDataSource()
    fetchMovies()
  }
  
  @objc
  private func fetchMovies() {
    let db = Firestore.firestore()
    let collectionName = "movies"
    
    db.collection(collectionName).getDocuments { [weak self] (snapshot, error) in
      if let error = error {
        print(error)
      }
      if let snapshot = snapshot {
        let movies = snapshot.documents.compactMap { try? $0.data(as: Movie.self) }
        dump(movies)
        self?.updateSnapshot(with: movies)
        self?.refreshControl.endRefreshing()
      }
    }
  }
  
  private func updateSnapshot(with movies: [Movie]) {
    var snapshot = dataSource.snapshot()
    
    snapshot.deleteAllItems()
    
    snapshot.appendSections([0])
    snapshot.appendItems(movies)
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
  private func configureCollectionView() {
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(fetchMovies), for: .valueChanged)
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.frame = view.bounds
    collectionView.backgroundColor = .systemGroupedBackground
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
    collectionView.refreshControl = refreshControl
    view.addSubview(collectionView)
  }
  
  private func createLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      // item
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let padding: CGFloat = 10
      item.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
      
      // group
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.80))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      // section
      let section = NSCollectionLayoutSection(group: group)
      
      return section
    }
  
    // layout
    return layout
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Int, Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {
        fatalError("could not dequeue a MovieCell")
      }
      cell.backgroundColor = .systemBackground
      cell.imageView.kf.setImage(with: URL(string: movie.imageURL))
      return cell
    })
  }

}

