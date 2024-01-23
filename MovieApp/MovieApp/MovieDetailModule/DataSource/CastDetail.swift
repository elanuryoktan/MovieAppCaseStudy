//
//  CastDetail.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

final class CastDetail: MovieDetails {
  let name: String
  let character: String
  let imageUrl: URL?

  init(
    name: String,
    character: String,
    imageUrl: URL?
  ) {
    self.name = name
    self.character = character
    self.imageUrl = imageUrl
  }
}

extension CastDetail: DiffableModel {
  var identifier: String {
    name + character
  }
}
