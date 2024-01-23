//
//  DataSourceSection.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation

class DataSourceSection<SectionType: Hashable>: Equatable {
  let rows: [MovieDetails]
  let sectionType: SectionType

  static func == (lhs: DataSourceSection, rhs: DataSourceSection) -> Bool {
    lhs.sectionType == rhs.sectionType
  }

  init(rows: [MovieDetails], sectionType: SectionType) {
    self.rows = rows
    self.sectionType = sectionType
  }
}
