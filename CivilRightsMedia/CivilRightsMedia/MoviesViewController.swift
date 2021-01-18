//
//  ViewController.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/17/21.
//

import UIKit
import Kingfisher
import FirebaseDatabase

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
    let db = Database.database().reference()
    let collectionName = "movies"
    
    db.child(collectionName).observeSingleEvent(of: .value) { [weak self] (snapshot) in
      var movies = [Movie]()
      for child in snapshot.children.allObjects as! [DataSnapshot] {
        if let dict = child.value as? [String: Any],
           let movie = Movie(dict) {
          movies.append(movie)
        }
      }
      self?.updateSnapshot(with: movies)
      self?.refreshControl.endRefreshing()
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
    collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
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
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.60))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      // section
      let section = NSCollectionLayoutSection(group: group)
      
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(500))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      section.boundarySupplementaryItems = [header]
      
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

