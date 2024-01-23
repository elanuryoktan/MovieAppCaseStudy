//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import RxSwift
import UIKit

protocol MovieDetailViewModelling {
  var movieDetails: PublishSubject<[DataSourceSection<DetailsSectionType>]> { get }
  func loadDetails()
  func movieDetails(for index: Int, cell: UICollectionViewCell) -> MovieDetails?
}

final class MovieDetailViewModel: MovieDetailViewModelling {
  var movieDetails = PublishSubject<[DataSourceSection<DetailsSectionType>]>()
  var movieDetailsList: [DataSourceSection<DetailsSectionType>] = []

  private var apiService: APIServicing
  private var mapper: MovieDetailsMapping
  private var domainModel: MovieDomainModel

  init(
    apiService: APIServicing,
    mapper: MovieDetailsMapping,
    domainModel: MovieDomainModel
  ) {
    self.apiService = apiService
    self.mapper = mapper
    self.domainModel = domainModel
  }
  
  func loadDetails() {
    // TODO: fetch genres
    // TODO: fetch cast members
    let dataSource = mapper.movieDetails(domainModel: domainModel)
    movieDetailsList.append(contentsOf: dataSource)
    movieDetails.onNext(dataSource)
  }

  func movieDetails(for index: Int, cell: UICollectionViewCell) -> MovieDetails? {
    var sectionType: DetailsSectionType?
    if let cell = cell as? PosterCollectionViewCell {
      sectionType = .poster
    }
    
    guard let sectionType = sectionType else {
      return nil
    }

    let models = movieDetailsList.filter({ $0.sectionType == sectionType}).first?.rows
    guard let models = models, models.count > index else {
      return nil
    }
    return models[index]
  }
}
