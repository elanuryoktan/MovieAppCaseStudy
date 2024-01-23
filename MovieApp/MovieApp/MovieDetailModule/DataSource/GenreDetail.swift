//
//  GenreDetail.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

final class GenreDetail: MovieDetails {
  let genres: [String]
  
  init(
    genres: [String]
  ) {
    self.genres = genres
  }
}

extension GenreDetail: DiffableModel {
  var identifier: String {
    genres.joined(separator: "_")
  }
}
