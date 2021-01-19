//
//  BaseViewController.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/18/21.
//

import UIKit

class BaseViewController: UIViewController {
  
  public var collectionView: UICollectionView!
  public var refreshControl: UIRefreshControl!
  public var dataSource: UICollectionViewDiffableDataSource<Int, AnyHashable>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
  }
  
  private func configureCollectionView() {
    refreshControl = UIRefreshControl()
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.frame = view.bounds
    collectionView.backgroundColor = .systemGroupedBackground
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
    collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
    collectionView.refreshControl = refreshControl
    view.addSubview(collectionView)
  }

  public func createLayout() -> UICollectionViewCompositionalLayout {
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
  
  public func updateSnapshot(with movies: [AnyHashable]) {
    var snapshot = dataSource.snapshot()
    snapshot.deleteAllItems()
    snapshot.appendSections([0])
    snapshot.appendItems(movies)
    dataSource.apply(snapshot, animatingDifferences: false)
  }

}
