//
//  MovieDetailsMapper.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

// sourcery: AutoMockable
protocol MovieDetailsMapping {
  func movieDetails(domainModel: MovieDomainModel) -> [ DataSourceSection<DetailsSectionType>]
}

final class MovieDetailsMapper: MovieDetailsMapping {
  enum Constants {
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
  }

  func movieDetails(domainModel: MovieDomainModel) -> [ DataSourceSection<DetailsSectionType>] {
    var imageUrl: URL?
    if let path = domainModel.posterPath {
      imageUrl = URL(string: Constants.imageBaseURL + path)
    }
    return [
      DataSourceSection(rows: [PosterDetail(imageUrl: imageUrl)], sectionType: .poster)
    ]
  }
}
