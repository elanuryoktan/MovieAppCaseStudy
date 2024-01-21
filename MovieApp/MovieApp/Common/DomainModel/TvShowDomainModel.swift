//
//  TvShowDomainModel.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 21.01.2024.
//

import Foundation

struct TvShowDomainModel: Decodable {
  let id: Int
  let adult: Bool
  let backdropPath, originalLanguage, originalName, overview, posterPath, firstAirDate, name: String?
  let genreIds: [Int]?
  let originCountry: [String]
  let popularity: Double
  let voteAverage: Double
  let voteCount: Double

  enum CodingKeys: String, CodingKey {
    case id
    case adult
    case backdropPath = "backdrop_path"
    case genreIds = "genre_ids"
    case originCountry = "origin_country"
    case originalLanguage = "original_language"
    case originalName = "original_name"
    case overview
    case popularity
    case posterPath = "poster_path"
    case firstAirDate = "first_air_date"
    case name
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}
