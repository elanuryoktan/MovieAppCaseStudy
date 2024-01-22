//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 22.01.2024.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.gray.cgColor
    view.layer.cornerRadius = 10
    return view
  }()
  
  private let titleLabel : UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.black
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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

  func configure(with viewModel: MovieViewModel) {
    titleLabel.text = viewModel.title
  }
}

private extension MovieCollectionViewCell {
  func setUp() {
    contentView.addSubview(containerView)
    containerView.addSubview(titleLabel)

    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
      titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
    ])
  }
}
 
