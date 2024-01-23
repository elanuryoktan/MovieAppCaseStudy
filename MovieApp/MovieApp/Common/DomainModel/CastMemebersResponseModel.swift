//
//  CastMemebersResponseModel.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

struct CastMemebersResponseModel: Decodable {
  let id: Int
  let cast: [CastMemberDomainModel]
    
  enum CodingKeys: String, CodingKey {
    case id
    case cast
  }
}
