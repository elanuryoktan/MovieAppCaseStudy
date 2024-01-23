//
//  OverviewCollectionViewCell.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import UIKit

class OverviewCollectionViewCell: UICollectionViewCell {
  var overviewLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.primaryText
    label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }
  
  override public func prepareForReuse() {
    super.prepareForReuse()
  }
}

extension OverviewCollectionViewCell: MovieDetailCell {
  func configure(with viewModel: any DiffableModel) {
    if let overviewModel = viewModel as? OverviewDetail {
      overviewLabel.text = overviewModel.overview
    }
  }
}

private extension OverviewCollectionViewCell {
  func setUp() {
    contentView.addSubview(overviewLabel)
    
    NSLayoutConstraint.activate([
      overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      overviewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
    ])
  }
}
