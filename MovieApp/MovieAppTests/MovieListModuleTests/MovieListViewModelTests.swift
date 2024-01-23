//
//  MovieListViewModelTests.swift
//  MovieAppTests
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import RxSwift
import XCTest
@testable import MovieApp

final class MovieListViewModelTests: XCTestCase {
  private let disposeBag = DisposeBag()

  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testOnViewSetup() {
    let dependencies = MovieListViewModelDeoendencies()
    dependencies.apiService.getPopularMoviesPageReturnValue = .just(.mock(movies: [.mock(title: "movie title")]))
    dependencies.mapper.movieViewModelDomainModelReturnValue = .mock(title: "movie title")
    let movieListViewModel = MovieListViewModel(
      apiService: dependencies.apiService,
      mapper: dependencies.mapper
    )

    let expectation = expectation(description: "Fetch movie list on view setup")
    movieListViewModel.onViewSetUp()

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(dependencies.apiService.invocations, [.getPopularMovies])
    XCTAssertEqual(dependencies.mapper.invocations.contains(.movieViewModel), true)
    XCTAssertEqual(movieListViewModel.movieViewModel(for: 0)?.title, "movie title")
  }
  
  func testOnLoadNextPage() {
    let dependencies = MovieListViewModelDeoendencies()
    dependencies.apiService.getPopularMoviesPageReturnValue = .just(.mock(movies: [.mock(title: "movie title")]))
    dependencies.mapper.movieViewModelDomainModelReturnValue = .mock(title: "movie title")
    let movieListViewModel = MovieListViewModel(
      apiService: dependencies.apiService,
      mapper: dependencies.mapper
    )

    let expectation = expectation(description: "Fetch movie list on page load")
    movieListViewModel.onViewSetUp()
    movieListViewModel.onLoadNextPage()

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(dependencies.apiService.getPopularMoviesPageCallsCount, 2)
    XCTAssertEqual(dependencies.mapper.movieViewModelDomainModelCallsCount, 2)
  }
  
  func testOnFail() {
    let dependencies = MovieListViewModelDeoendencies()
    dependencies.apiService.getPopularMoviesPageReturnValue = Single.create { single in
      single(.failure(APIService.ApiError.invalidKey))
      return Disposables.create()
    }
    let movieListViewModel = MovieListViewModel(
      apiService: dependencies.apiService,
      mapper: dependencies.mapper
    )

    let expectation = expectation(description: "Get fail message when receive error from api service")
    movieListViewModel.onViewSetUp()
    var errorMessage: (String, String)?

    movieListViewModel.errorMessage
      .observe(on: MainScheduler.asyncInstance)
      .subscribe { message in
        errorMessage = message
        expectation.fulfill()
      }
      .disposed(by: disposeBag)

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(dependencies.apiService.getPopularMoviesPageCallsCount, 1)
    XCTAssertEqual(dependencies.mapper.invocations.count, 0)
    XCTAssertEqual(movieListViewModel.movieViewModel(for: 0), nil)
    XCTAssertEqual(errorMessage?.1, APIService.ApiError.invalidKey.getErrorMessage())
  }
}
