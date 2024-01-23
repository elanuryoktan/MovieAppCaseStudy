//
//  TitleDetailCollectionViewCell.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import UIKit

class TitleDetailCollectionViewCell: UICollectionViewCell {
  var titleLabel: UILabel = {
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

extension TitleDetailCollectionViewCell: MovieDetailCell {
  func configure(with viewModel: any DiffableModel) {
    if let titleModel = viewModel as? TitleDetail {
      titleLabel.attributedText = titleModel.title
    }
  }
}

private extension TitleDetailCollectionViewCell {
  func setUp() {
    contentView.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
    ])
  }
}

