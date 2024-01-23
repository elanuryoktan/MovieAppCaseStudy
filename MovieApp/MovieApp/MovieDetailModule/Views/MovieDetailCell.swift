//
//  MovieDetailCell.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import UIKit

protocol MovieDetailCell: UICollectionViewCell {
  func configure(with viewModel: any DiffableModel)
}
