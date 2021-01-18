//
//  Movie.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/17/21.
//

import Foundation

struct MovieWrapper: Codable {
  let results: [Movie]
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
  
  private enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIds = "genre_ids"
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview
    case popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title
    case video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
  
  var imageURL: String {
    guard let posterPath = posterPath else {
      return "no poster path - use a placeholder image"
    }
    return "https://image.tmdb.org/t/p/w185/\(posterPath)"
  }
}


extension Movie {
  init?(_ dict: [String: Any]) {
    guard let adult = dict["adult"] as? Bool,
          let backdropPath = dict["backdropPath"] as? String,
          let genreIds = dict["genreIds"] as? [Int],
          let id = dict["id"] as? Int,
          let originalLanguage = dict["originalLanguage"] as? String,
          let originalTitle = dict["originalTitle"] as? String,
          let overview = dict["overview"] as? String,
          let popularity = dict["popularity"] as? Double,
          let posterPath = dict["posterPath"] as? String,
          let releaseDate = dict["releaseDate"] as? String,
          let title = dict["title"] as? String,
          let video = dict["video"] as? Bool,
          let voteAverage = dict["voteAverage"] as? Double,
          let voteCount = dict["voteCount"] as? Int
    else {
      return nil
    }
    self.adult = adult
    self.backdropPath = backdropPath
    self.genreIds = genreIds
    self.id = id
    self.originalLanguage = originalLanguage
    self.originalTitle = originalTitle
    self.overview = overview
    self.popularity = popularity
    self.posterPath = posterPath
    self.releaseDate = releaseDate
    self.title = title
    self.video = video
    self.voteAverage = voteAverage
    self.voteCount = voteCount
  }
}
