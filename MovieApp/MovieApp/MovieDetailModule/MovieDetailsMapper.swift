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
      DataSourceSection(rows: [PosterDetail(imageUrl: imageUrl)], sectionType: .poster),
      DataSourceSection(rows: getTitlemodels(domainModel: domainModel), sectionType: .title),
      DataSourceSection(rows: [getOverviewDetail(domainModel: domainModel)], sectionType: .overview)
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
}
