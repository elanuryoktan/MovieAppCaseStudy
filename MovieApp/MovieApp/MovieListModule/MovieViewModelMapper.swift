//
//  MovieViewModelMapper.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 22.01.2024.
//

import Foundation

protocol MovieViewModelMapping {
  func movieViewModel(domainModel: MovieDomainModel) -> MovieViewModel
}

final class MovieViewModelMapper: MovieViewModelMapping {
  func movieViewModel(domainModel: MovieDomainModel) -> MovieViewModel {
    return MovieViewModel(
      title: domainModel.title ?? domainModel.originalTitle ?? "",
      imageUrl: domainModel.backdropPath
    )
  }
}
