// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// For more details check wiki:
// https://github.com/deliveryhero/dh-verticals-ios/wiki/Automatic-mock-generation-using-Sourcery
// swiftlint:disable all

import Foundation
import UIKit
import RxSwift
@testable import MovieApp

class APIServicingMock: APIServicing {

  enum Invocations: Equatable {
    case getPopularMovies
    case getMovieGenres
  }

  var invocations: [Invocations] = []

    //MARK: - getPopularMovies

    var getPopularMoviesPageCallsCount = 0
    var getPopularMoviesPageCalled: Bool {
        return getPopularMoviesPageCallsCount > 0
    }
    var getPopularMoviesPageReceivedPage: (Int)?
    var getPopularMoviesPageReceivedInvocations: [(Int)] = []
    var getPopularMoviesPageReturnValue: Single<PopularMoviesResponseModel>!
    var getPopularMoviesPageClosure: ((Int) -> Single<PopularMoviesResponseModel>)?

    func getPopularMovies(page: Int) -> Single<PopularMoviesResponseModel> {
      invocations.append(.getPopularMovies)
      getPopularMoviesPageCallsCount += 1
        getPopularMoviesPageReceivedPage = page
        getPopularMoviesPageReceivedInvocations.append(page)
        if let getPopularMoviesPageClosure = getPopularMoviesPageClosure {
            return getPopularMoviesPageClosure(page)
        } else {
            return getPopularMoviesPageReturnValue
        }
    }

    //MARK: - getMovieGenres

    var getMovieGenresCallsCount = 0
    var getMovieGenresCalled: Bool {
        return getMovieGenresCallsCount > 0
    }
    var getMovieGenresReturnValue: Single<GenreResponseModel>!
    var getMovieGenresClosure: (() -> Single<GenreResponseModel>)?

    func getMovieGenres() -> Single<GenreResponseModel> {
      invocations.append(.getMovieGenres)
      getMovieGenresCallsCount += 1
        if let getMovieGenresClosure = getMovieGenresClosure {
            return getMovieGenresClosure()
        } else {
            return getMovieGenresReturnValue
        }
    }

}
