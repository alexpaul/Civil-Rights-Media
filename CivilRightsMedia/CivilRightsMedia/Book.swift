//
//  Book.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/18/21.
//

import Foundation

struct BookWrapper: Codable {
  let books: [String: Book]
}

struct Book: Codable, Hashable {
  let id: String
  let title: String
  let thumbnail: String
  let description: String
  let authors: [String]
}
