//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 22.01.2024.
//

import Foundation
import Kingfisher
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
  private lazy var containerView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.layer.borderWidth = 1
    stackView.layer.borderColor = UIColor.gray.cgColor
    stackView.layer.cornerRadius = 10
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 16
    stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.addArrangedSubview(posterImageView)
    stackView.addArrangedSubview(titleLabel)
    return stackView
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
  
  private let posterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = UIView.ContentMode.scaleAspectFill
    imageView.clipsToBounds = true
    imageView.image = UIImage(named: "moviePlaceholder")
    imageView.layer.cornerRadius = 10
    return imageView
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
    if let imgUrl = viewModel.imageUrl {
      posterImageView.kf.setImage(with: imgUrl)
    }
  }
}

private extension MovieCollectionViewCell {
  func setUp() {
    contentView.addSubview(containerView)
    
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      posterImageView.heightAnchor.constraint(equalToConstant: 80),
      posterImageView.widthAnchor.constraint(equalToConstant: 80)
    ])
  }
}
 
