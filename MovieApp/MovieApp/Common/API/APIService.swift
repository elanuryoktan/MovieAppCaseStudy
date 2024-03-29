//
//  APIService.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 21.01.2024.
//

import Alamofire
import Foundation
import RxSwift

// sourcery: AutoMockable
protocol APIServicing {
  func getPopularMovies(page: Int) -> Single<PopularMoviesResponseModel>
  func getMovieGenres() -> Single<GenreResponseModel>
  func getCastMembers(movieId: Int) -> Single<CastMemebersResponseModel>
}

final class APIService: APIServicing {
  enum ApiError: Error {
    case serverFailure
    case invalidKey
    case invalidResponse
    
    func getErrorMessage() -> String {
      switch self {
      case .serverFailure:
        return "Server failure"
      case .invalidKey:
        return "Invalid api key, please check you have the right access"
      case .invalidResponse:
        return "Invalid reponse from API"
      }
    }
  }
  
  let apiKeyManager: ApiKeyManaging
  public let sessionManager = Session()
  let disposeBag = DisposeBag()

  init(apiKeyManager: ApiKeyManaging) {
    self.apiKeyManager = apiKeyManager
  }

  // Used to get popular movies via using Movie Database API
  func getPopularMovies(page: Int) -> Single<PopularMoviesResponseModel> {
    return Single.create { single in
      self.apiKeyManager.tmdbApiKey { [weak self] apiKey in
        guard let self = self else {
          return
        }
        guard let apiKey = apiKey else {
          return single(.failure(ApiError.invalidKey))
        }
        
        let result: Single<PopularMoviesResponseModel> = self.buildRequest(
          convertible: Router.getPopularTvShows(
            apiKey: apiKey,
            page: page,
            language: Locale.preferredLanguages[0]
          )
        )

        let _ = result.subscribe { event in
          switch event {
          case .success(let moviesResponse):
            single(.success(moviesResponse))
          case .failure(let error):
            single(.failure(error))
          }
        }
      }
      return Disposables.create()
    }
  }

  // Used to get movie genres
  func getMovieGenres() -> Single<GenreResponseModel> {
    return Single.create { single in
      self.apiKeyManager.tmdbApiKey { [weak self] apiKey in
        guard let self = self else {
          return
        }
        guard let apiKey = apiKey else {
          return single(.failure(ApiError.invalidKey))
        }
        
        let result: Single<GenreResponseModel> = self.buildRequest(
          convertible: Router.getGenres(
            apiKey: apiKey,
            language: Locale.preferredLanguages[0]
          )
        )

        let _ = result.subscribe { event in
          switch event {
          case .success(let genreResponse):
            single(.success(genreResponse))
          case .failure(let error):
            single(.failure(error))
          }
        }
      }
      return Disposables.create()
    }
  }
  
  // Used to get cast members via using Movie Database API
  func getCastMembers(movieId: Int) -> Single<CastMemebersResponseModel> {
    return Single.create { single in
      self.apiKeyManager.tmdbApiKey { [weak self] apiKey in
        guard let self = self else {
          return
        }
        guard let apiKey = apiKey else {
          return single(.failure(ApiError.invalidKey))
        }
        
        let result: Single<CastMemebersResponseModel> = self.buildRequest(
          convertible: Router.getCastMembers(
            apiKey: apiKey,
            language: Locale.preferredLanguages[0],
            movieId: movieId
          )
        )
        
        let _ = result.subscribe { event in
          switch event {
          case .success(let castResponse):
            single(.success(castResponse))
          case .failure(let error):
            single(.failure(error))
          }
        }
      }
      return Disposables.create()
    }
  }
}

private extension APIService {
  // Generic function to get and parse api response
  private func buildRequest<T: Decodable>(convertible: URLRequestConvertible) -> Single<T> {
    return Single.create { single in
      self.sessionManager.request(convertible)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
          switch response.result {
          case let .success(model):
            single(.success(model))
          case .failure:
            single(.failure(ApiError.invalidResponse))
          }
        }
      return Disposables.create()
    }
  }
}
