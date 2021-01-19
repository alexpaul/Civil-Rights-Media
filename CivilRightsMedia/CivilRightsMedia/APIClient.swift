//
//  APIClient.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/18/21.
//

import Foundation

struct APIClient<T: Codable> {
  func fetchMediaItems(completion: @escaping (Result<T, Error>) -> ()) {
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
          let items = try JSONDecoder().decode(T.self, from: data)
          //let movies = results.movies.map { $0.value }
          return completion(.success(items))
        } catch {
          return completion(.failure(error))
        }
      }
    }
    dataTask.resume()
  }
}
