//
//  CastDetailCollectionViewCell.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import UIKit

class CastDetailCollectionViewCell: UICollectionViewCell {
  private var containerView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.backgroundColor = UIColor.cellBackground
    stackView.layer.borderWidth = 1
    stackView.layer.borderColor = UIColor.border.cgColor
    stackView.layer.cornerRadius = 10
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 4
    stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    stackView.isLayoutMarginsRelativeArrangement = true
    return stackView
  }()

  private var infoStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.spacing = 2
    stackView.isLayoutMarginsRelativeArrangement = true
    return stackView
  }()
  
  private let nameLabel : UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.primaryText
    label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  private let characterLabel : UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.secondaryLabel
    label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
  private let posterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = UIView.ContentMode.scaleAspectFill
    imageView.clipsToBounds = true
    imageView.image = UIImage(named: "personPlaceholder")
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
    posterImageView.image = nil
  }
}

extension CastDetailCollectionViewCell: MovieDetailCell {
  func configure(with viewModel: any DiffableModel) {
    if let castDetailModel = viewModel as? CastDetail {
      nameLabel.text = castDetailModel.name
      characterLabel.text = castDetailModel.character
      if let imgUrl = castDetailModel.imageUrl {
        posterImageView.kf.setImage(with: imgUrl)
      }
    }
  }
}

private extension CastDetailCollectionViewCell {
  func setUp() {
    contentView.addSubview(containerView)
    infoStackView.addArrangedSubview(nameLabel)
    infoStackView.addArrangedSubview(characterLabel)
    containerView.addArrangedSubview(posterImageView)
    containerView.addArrangedSubview(infoStackView)
    
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
      posterImageView.heightAnchor.constraint(equalToConstant: 40),
      posterImageView.widthAnchor.constraint(equalToConstant: 40)
    ])
  }
}
