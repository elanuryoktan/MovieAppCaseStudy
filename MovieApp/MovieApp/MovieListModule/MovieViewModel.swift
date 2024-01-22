//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 22.01.2024.
//

import Foundation

struct MovieViewModel: Hashable {
  let title: String
  let imageUrl: URL?
  let rating: Double
}

extension MovieViewModel {
  var identifier: String {
    title
  }
}
