//
//  PosterCollectionViewCell.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
  var posterImageView: UIImageView = {
    let imageview = UIImageView()
    imageview.translatesAutoresizingMaskIntoConstraints = false
    imageview.contentMode = .scaleAspectFill
    imageview.image = UIImage(named: "movie_placeholder")
    imageview.clipsToBounds = true
    return imageview
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

extension PosterCollectionViewCell: MovieDetailCell {
  func configure(with viewModel: any DiffableModel) {
    if let posterModel = viewModel as? PosterDetail, let imgUrl = posterModel.imageUrl {
      posterImageView.kf.setImage(with: imgUrl)
    }
  }
}

private extension PosterCollectionViewCell {
  func setUp() {
    contentView.addSubview(posterImageView)
    
    NSLayoutConstraint.activate([
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5)
    ])
  }
}
