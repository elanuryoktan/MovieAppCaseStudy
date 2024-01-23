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
  private var disposeBag = DisposeBag()

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
    let dataSource = mapper.movieDetails(domainModel: domainModel, genres: [], castDetails: [])
    movieDetailsList.append(contentsOf: dataSource)
    movieDetails.onNext(dataSource)
    
    // Fetch genres
    apiService.getMovieGenres()
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(
        onSuccess: { [weak self] genreResponseModel in
          guard let self = self else { return }
          let dataSource = mapper.movieDetails(domainModel: domainModel, genres: genreResponseModel.genres, castDetails: [])
          movieDetailsList.removeAll()
          movieDetailsList.append(contentsOf: dataSource)
          movieDetails.onNext(dataSource)
        },
        onFailure: { _ in }
      )
      .disposed(by: disposeBag)
    
    // Fetch cast members
    apiService.getCastMembers(movieId: domainModel.id)
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(
        onSuccess: { [weak self] castResponse in
          guard let self = self else { return }
          let dataSource = mapper.movieDetails(domainModel: domainModel, genres: [], castDetails: castResponse.cast)
          movieDetailsList.removeAll()
          movieDetailsList.append(contentsOf: dataSource)
          movieDetails.onNext(dataSource)
        },
        onFailure: { _ in }
      )
      .disposed(by: disposeBag)
  }

  func movieDetails(for index: Int, cell: UICollectionViewCell) -> MovieDetails? {
    var sectionType: DetailsSectionType?
    if let _ = cell as? PosterCollectionViewCell {
      sectionType = .poster
    } else if let _ = cell as? OverviewCollectionViewCell {
      sectionType = .overview
    } else if let _ = cell as? TitleDetailCollectionViewCell {
      sectionType = .title
    } else if let _ = cell as? GenreDetailCollectionViewCell {
      sectionType = .genre
    } else if let _ = cell as? CastDetailCollectionViewCell {
      sectionType = .cast
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
