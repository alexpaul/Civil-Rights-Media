//
//  Movie.swift
//  TestCivilRightsAPI
//
//  Created by Alex Paul on 1/18/21.
//

import Foundation

struct MovieWrapper: Codable {
  let movies: [String: Movie]
}

struct Movie: Codable, Hashable {
  let adult: Bool
  let backdropPath: String?
  let genreIds: [Int]
  let id: Int
  let originalLanguage: String
  let originalTitle: String
  let overview: String
  let popularity: Double
  let posterPath: String?
  let releaseDate: String
  let title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  
  var imageURL: String {
    guard let posterPath = posterPath else {
      return "no poster path - use a placeholder image"
    }
    return "https://image.tmdb.org/t/p/w185/\(posterPath)"
  }
}
