//
//  ViewController.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/17/21.
//

import UIKit

class MoviesViewController: UIViewController {
  
  private var collectionView: UICollectionView!
  
  private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!

  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configureDataSource()
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.frame = view.bounds
    collectionView.backgroundColor = .systemBackground
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
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
    dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {
        fatalError("could not dequeue a MovieCell")
      }
      cell.backgroundColor = .systemOrange
      return cell
    })

    var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
    snapshot.appendSections([0])
    snapshot.appendItems(Array(1...20))
    dataSource.apply(snapshot, animatingDifferences: false)
  }

}

