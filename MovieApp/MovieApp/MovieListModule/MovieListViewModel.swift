//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 22.01.2024.
//

import Foundation
import RxSwift

protocol MovieLisViewModelling {
  var movies: PublishSubject<[MovieViewModel]> { get }
  func fetchMovies()
}

final class MovieListViewModel: MovieLisViewModelling {
  var movies = PublishSubject<[MovieViewModel]>()
  
  private var apiService: APIServicing
  private var mapper: MovieViewModelMapping
  private var currentPage: Int = 1
  private var disposeBag = DisposeBag()

  init(
    apiService: APIServicing,
    mapper: MovieViewModelMapping
  ) {
    self.apiService = apiService
    self.mapper = mapper
    fetchMovies()
  }
  
  func fetchMovies() {
    apiService.getPopularMovies(page: currentPage)
      .observe(on: MainScheduler.asyncInstance)
      .flatMap { movieListResponseModel -> Single<[MovieViewModel]> in
          .just( movieListResponseModel.results.map {
            self.mapper.movieViewModel(domainModel: $0)
          })
      }
      .subscribe(
        onSuccess: { [weak self] movieList in
          guard let self = self else { return }
          movies.onNext(movieList)
        },
        onFailure: { _ in
          // TODO: create publish subject to set fail messages
        }
      )
      .disposed(by: disposeBag)
  }
}
