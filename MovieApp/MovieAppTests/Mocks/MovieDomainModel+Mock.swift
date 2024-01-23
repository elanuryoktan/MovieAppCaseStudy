//
//  MovieDomainModel+Mock.swift
//  MovieAppTests
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
@testable import MovieApp

extension MovieDomainModel {
  static func mock(
    id: Int = 1,
    title: String = "movie_title"
  ) -> MovieDomainModel {
    MovieDomainModel(
      id: id,
      adult: false,
      video: false,
      backdropPath: nil,
      originalLanguage: nil,
      originalTitle: title,
      overview: nil,
      posterPath: nil,
      releaseDate: nil,
      title: title,
      genreIds: nil,
      popularity: 0,
      voteAverage: 0,
      voteCount: 0
    )
  }
}
