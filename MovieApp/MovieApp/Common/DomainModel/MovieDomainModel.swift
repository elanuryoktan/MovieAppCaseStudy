//
//  TvShowDomainModel.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 21.01.2024.
//

import Foundation

struct MovieDomainModel: Decodable {
  let id: Int
  let adult, video: Bool
  let backdropPath, originalLanguage, originalTitle, overview, posterPath, releaseDate, title: String?
  let genreIds: [Int]?
  let popularity: Double
  let voteAverage: Double
  let voteCount: Double

  enum CodingKeys: String, CodingKey {
    case id
    case adult
    case backdropPath = "backdrop_path"
    case genreIds = "genre_ids"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview
    case popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title
    case video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}
