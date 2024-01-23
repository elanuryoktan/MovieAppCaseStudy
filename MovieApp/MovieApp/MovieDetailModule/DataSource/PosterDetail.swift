//
//  PosterDetail.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

final class PosterDetail: MovieDetails {
  let id: String
  let imageUrl: URL?
  
  init(
    id: String? = nil,
    imageUrl: URL?
  ) {
    self.id = id ?? UUID().uuidString
    self.imageUrl = imageUrl
  }
}

extension PosterDetail: DiffableModel {
  var identifier: String {
    id
  }
}
