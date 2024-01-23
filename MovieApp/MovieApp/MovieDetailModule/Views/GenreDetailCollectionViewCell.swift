//
//  GenreDetailCollectionViewCell.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import UIKit

class GenreDetailCollectionViewCell: UICollectionViewCell {
  private var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .leading
    stackView.spacing = 4
    stackView.isLayoutMarginsRelativeArrangement = true
    return stackView
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
    stackView.removeAllSubviews()
  }
}

extension GenreDetailCollectionViewCell: MovieDetailCell {
  func configure(with viewModel: any DiffableModel) {
    stackView.removeAllSubviews()
    if let genreModel = viewModel as? GenreDetail {
      for genre in genreModel.genres {
        let label = UILabel()
        label.textColor = UIColor.primaryText
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.layer.borderColor = UIColor.border.cgColor
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.backgroundColor = UIColor.cellBackground
        label.text = genre
        stackView.addArrangedSubview(label)
      }
    }
  }
}

private extension GenreDetailCollectionViewCell {
  func setUp() {
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
    ])
  }
}

extension UIStackView {
  func removeAllSubviews() {
    for subview in arrangedSubviews {
      subview.removeFromSuperview()
    }
  }
}
