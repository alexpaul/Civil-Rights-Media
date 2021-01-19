//
//  CivilRightsMediaTabController.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/18/21.
//

import UIKit

class CivilRightsMediaTabController: UITabBarController {
  
  private let moviesViewController: MoviesViewController = {
    let vc = MoviesViewController()
    vc.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film.fill"), tag: 0)
    return vc
  }()
  
  private let booksViewController: BooksViewController = {
    let vc = BooksViewController()
    vc.tabBarItem = UITabBarItem(title: "Books", image: UIImage(systemName: "books.vertical.fill"), tag: 1)
    return vc
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers = [moviesViewController, booksViewController]
  }
  
}
