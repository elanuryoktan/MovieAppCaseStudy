//
//  CastMemberDomainModel.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

struct CastMemberDomainModel: Decodable {
  let id: Int
  let name: String?
  let character: String?
  let profilePath: String?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case character
    case profilePath = "profile_path"
  }
}
