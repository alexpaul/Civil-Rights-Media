//
//  ViewController.swift
//  TestCivilRightsAPI
//
//  Created by Alex Paul on 1/18/21.
//

import UIKit

class MoviesViewController: UIViewController {
  
  private let apiClient = APIClient()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    apiClient.fetchMovies { (result) in
      switch result {
      case .failure(let error):
        print(error)
      case .success(let movies):
        dump(movies)
      }
    }
  }


}

