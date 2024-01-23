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
  var errorMessage: PublishSubject<(String, String)> { get }
  func onViewSetUp()
  func onLoadNextPage()
  func movieViewModel(for index: Int) -> MovieViewModel?
}

final class MovieListViewModel: MovieLisViewModelling {
  var movies = PublishSubject<[MovieViewModel]>()
  var errorMessage = PublishSubject<(String, String)>()

  private var movieList: [MovieViewModel] = []
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
  }

  func onViewSetUp() {
    fetchMovies()
  }
  
  func onLoadNextPage() {
    currentPage += 1
    fetchMovies()
  }

  func movieViewModel(for index: Int) -> MovieViewModel? {
    guard index < movieList.count else {
      return nil
    }
    return movieList[index]
  }
}

private extension MovieListViewModel {
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
          self.movieList.append(contentsOf: movieList)
          movies.onNext(movieList)
        },
        onFailure: { [weak self] error in
          guard let self = self else { return }
          if let apiError = error as? APIService.ApiError {
            self.errorMessage.onNext(("Unexpected Error", apiError.getErrorMessage()))
          } else {
            self.errorMessage.onNext(("Unexpected Error", "Please check your connection"))
          }
        }
      )
      .disposed(by: disposeBag)
  }
}
