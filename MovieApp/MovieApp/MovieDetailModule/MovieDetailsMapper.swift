//
//  MovieDetailsMapper.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol MovieDetailsMapping {
  func movieDetails(domainModel: MovieDomainModel, genres: [Genre], castDetails: [CastMemberDomainModel]) -> [ DataSourceSection<DetailsSectionType>]
}

final class MovieDetailsMapper: MovieDetailsMapping {
  enum Constants {
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
  }

  func movieDetails(domainModel: MovieDomainModel, genres: [Genre], castDetails: [CastMemberDomainModel]) -> [ DataSourceSection<DetailsSectionType>] {
    var imageUrl: URL?
    if let path = domainModel.posterPath {
      imageUrl = URL(string: Constants.imageBaseURL + path)
    }

    return [
      DataSourceSection(rows: [PosterDetail(imageUrl: imageUrl)], sectionType: .poster),
      DataSourceSection(rows: getTitlemodels(domainModel: domainModel), sectionType: .title),
      DataSourceSection(rows: getGenres(domainModel: domainModel, genres: genres), sectionType: .genre),
      DataSourceSection(rows: [getOverviewDetail(domainModel: domainModel)], sectionType: .overview),
      DataSourceSection(rows: castModels(cast: castDetails), sectionType: .cast)
    ]
  }
}

private extension MovieDetailsMapper {
  func getOverviewDetail(domainModel: MovieDomainModel) -> OverviewDetail {
    return OverviewDetail(overview: domainModel.overview ?? domainModel.title ?? domainModel.originalTitle ?? "")
  }
  
  func getTitlemodels(domainModel: MovieDomainModel) -> [TitleDetail] {
    var titleDataSource: [TitleDetail] = []
    if let titleModel = getTitle(domainModel: domainModel) {
      titleDataSource.append(titleModel)
    }
    
    if let titleModel = getOriginalTitle(domainModel: domainModel) {
      titleDataSource.append(titleModel)
    }
    return titleDataSource
  }
  
  func getTitle(domainModel: MovieDomainModel) -> TitleDetail? {
    guard let title = domainModel.title else {
      return nil
    }
    return TitleDetail(title: NSAttributedString(
      string: title,
      attributes: [
        .foregroundColor: UIColor.primaryText,
        .font: UIFont.boldSystemFont(ofSize: 16.0)
      ])
    )
  }
  
  func getOriginalTitle(domainModel: MovieDomainModel) -> TitleDetail? {
    guard let originalTitle = domainModel.originalTitle else {
      return nil
    }
    return TitleDetail(title: NSAttributedString(
      string: originalTitle,
      attributes: [
        .foregroundColor: UIColor.secondaryLabel,
        .font: UIFont.boldSystemFont(ofSize: 12.0)
      ])
    )
  }
  
  func getGenres(domainModel: MovieDomainModel, genres: [Genre]) -> [GenreDetail] {
    var genreTexts: [String] = []
    domainModel.genreIds?.forEach({ genreId in
      if let genreText = genres.filter({ $0.id == genreId }).first?.name {
        genreTexts.append(genreText)
      }
    })
    if genreTexts.count > 0 {
      return [GenreDetail(genres: genreTexts)]
    }
    return []
  }
  
  func castModels(cast: [CastMemberDomainModel]) -> [CastDetail] {
    var castModels: [CastDetail] = []
    cast.forEach { castDomainModel in
      var imageUrl: URL?
      if let path = castDomainModel.profilePath {
        imageUrl = URL(string: Constants.imageBaseURL + path)
      }
      if let name = castDomainModel.name {
        let viewModel = CastDetail(
          name: name,
          character: castDomainModel.character ?? "",
          imageUrl: imageUrl
        )
        castModels.append(viewModel)
      }
    }
    return castModels
  }
}
