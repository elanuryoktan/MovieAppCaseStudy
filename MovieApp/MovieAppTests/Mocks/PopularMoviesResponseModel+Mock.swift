//
//  PopularMoviesResponseModel+Mock.swift
//  MovieAppTests
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
@testable import MovieApp

extension PopularMoviesResponseModel {
  static func mock(
    page: Int = 1,
    movies: [MovieDomainModel]
  ) -> PopularMoviesResponseModel {
    PopularMoviesResponseModel(
      page: page,
      results: movies,
      totalPages: 0,
      totalResults: 0
    )
  }
}
