//
//  Router.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 21.01.2024.
//

import Foundation
import Alamofire

internal enum Router: URLRequestConvertible {
  enum Constants {
    static let movieDBApiBaseURL = "https://api.themoviedb.org/3/"
    static let cacheTimeout = 300.0
  }

  case getPopularTvShows(apiKey: String, page: Int, language: String)
  case getGenres(apiKey: String, language: String)

  func asURLRequest() throws -> URLRequest {
    var method: HTTPMethod {
      switch self {
      case .getPopularTvShows, .getGenres:
          return .get
      }
    }

    let parameters: [String: Any]? = {
      switch self {
      case .getPopularTvShows(let apiKey, let page, let language):
        return [
          "api_key": apiKey,
          "page": page,
          "language": language
        ]
      case .getGenres(let apiKey, let language):
        return [
          "api_key": apiKey,
          "language": language
        ]
      }
    }()

    let headers: HTTPHeaders? = {
      switch self {
      case .getPopularTvShows, .getGenres:
        return nil
      }
    }()

    let url: URL = {
      let relativePath: String?
      let query = ""

      switch self {
      case .getPopularTvShows:
        relativePath = "movie/popular"
      case .getGenres:
        relativePath = "genre/movie/list"
      }
      
      var url = URL(string: Constants.movieDBApiBaseURL)!
      if let relativePath = relativePath {
        url.appendPathComponent(relativePath)
        let urlString = (url.absoluteString + query)
          .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? (url.absoluteString + query)
        url = URL(string: urlString)!
      }
      return url
    }()

    let cachePolicy: NSURLRequest.CachePolicy = NetworkReachabilityManager()?.isReachable ?? false ?
      .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad
    var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: Constants.cacheTimeout)
    urlRequest.httpMethod = method.rawValue

    return try URLEncoding.default.encode(
      URLRequest(
        url: url,
        method: method,
        headers: headers
      ),
      with: parameters
    )
  }
}
