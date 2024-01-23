//
//  MovieViewModelMapper.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 22.01.2024.
//

import Foundation

// sourcery: AutoMockable
protocol MovieViewModelMapping {
  func movieViewModel(domainModel: MovieDomainModel) -> MovieViewModel
}

final class MovieViewModelMapper: MovieViewModelMapping {
  enum Constants {
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
  }

  func movieViewModel(domainModel: MovieDomainModel) -> MovieViewModel {
    var imageUrl: URL?
    if let path = domainModel.backdropPath {
      imageUrl = URL(string: Constants.imageBaseURL + path)
    }
    return MovieViewModel(
      title: domainModel.title ?? domainModel.originalTitle ?? "",
      imageUrl: imageUrl,
      rating: domainModel.voteAverage
    )
  }
}
