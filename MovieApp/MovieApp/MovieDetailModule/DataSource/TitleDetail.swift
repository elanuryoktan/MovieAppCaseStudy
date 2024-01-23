//
//  TitleDetail.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import UIKit

final class TitleDetail: MovieDetails {
  let title: NSAttributedString
  
  init(
    title: NSAttributedString
  ) {
    self.title = title
  }
}

extension TitleDetail: DiffableModel {
  var identifier: String {
    title.string
  }
}
