//
//  APIClient.swift
//  TestCivilRightsAPI
//
//  Created by Alex Paul on 1/18/21.
//

import Foundation

struct APIClient {
  func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
    let endpoint = "https://civilrights-media-default-rtdb.firebaseio.com/.json"
    guard let url = URL(string: endpoint) else {
      fatalError("bad url")
    }
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        return completion(.failure(error))
      }
      if let data = data {
        do {
          let results = try JSONDecoder().decode(MovieWrapper.self, from: data)
          let movies = results.movies.map { $0.value }
          return completion(.success(movies))
        } catch {
          return completion(.failure(error))
        }
      }
    }
    dataTask.resume()
  }
}
