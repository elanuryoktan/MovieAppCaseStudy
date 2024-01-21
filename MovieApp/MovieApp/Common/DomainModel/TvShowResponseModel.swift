//
//  TvShowResponseModel.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 21.01.2024.
//

import Foundation

struct TvShowResponseModel: Decodable {
  let page: Int
  let results: [TvShowDomainModel]
  let totalPages: Int
  let totalResults: Int
    
  enum CodingKeys: String, CodingKey {
    case page
    case results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}
