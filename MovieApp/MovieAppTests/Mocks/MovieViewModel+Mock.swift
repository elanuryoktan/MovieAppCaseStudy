//
//  MovieViewModel+Mock.swift
//  MovieAppTests
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
@testable import MovieApp

extension MovieViewModel {
  static func mock(
    title: String = "movie_title",
    rating: Double = 0
  ) -> MovieViewModel {
    MovieViewModel(
      title: title,
      imageUrl: nil,
      rating: rating
    )
  }
}
