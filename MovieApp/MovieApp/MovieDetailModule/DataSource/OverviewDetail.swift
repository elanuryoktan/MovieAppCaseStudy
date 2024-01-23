//
//  OverviewDetail.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

final class OverviewDetail: MovieDetails {
  let overview: String
  
  init(
    overview: String
  ) {
    self.overview = overview
  }
}

extension OverviewDetail: DiffableModel {
  var identifier: String {
    overview
  }
}
