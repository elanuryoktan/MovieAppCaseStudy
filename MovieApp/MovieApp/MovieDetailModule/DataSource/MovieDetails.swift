//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

protocol DiffableModel: Hashable {
  var identifier: String { get }
}

extension DiffableModel {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
}

public class MovieDetails: NSObject {
  public override var hash: Int {
    if let diffableModel = self as? (any DiffableModel) {
      return diffableModel.identifier.hashValue
    } else {
      return super.hash
    }
  }
}

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
