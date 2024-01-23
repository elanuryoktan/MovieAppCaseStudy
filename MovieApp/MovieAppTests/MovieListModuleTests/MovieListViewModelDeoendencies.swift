//
//  MovieListViewModelDeoendencies.swift
//  MovieAppTests
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

struct MovieListViewModelDeoendencies {
  let apiService = APIServicingMock()
  let mapper = MovieViewModelMappingMock()
}
