//
//  StarRatingView.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 23.01.2024.
//

import Foundation
import UIKit

protocol StarReatingViewing {
  func setRate(rating: Double)
}

final class StarRatingView: UIView {
  enum Constants {
    static let defaultStarCount = 5
    static let defaultScale = 10
    static let padding: CGFloat = 1
  }
  private var starImageViews: [UIImageView] = []
  private var starCount: Int = Constants.defaultStarCount
  private var scale: Int = Constants.defaultScale

  init(
    starCount: Int = Constants.defaultStarCount,
    scale: Int = Constants.defaultScale
  ) {
    guard starCount > 1, scale > 1 else {
      fatalError("Star count and scale should bigger than 1")
    }
    self.starCount = starCount
    self.scale = scale
    super.init(frame: .zero)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    starCount = Constants.defaultStarCount
    scale = Constants.defaultScale
    super.init(coder: coder)
  }

  func setUp() {
    for index in 0..<starCount {
      let starImageView = UIImageView(
        frame: CGRect(x: (15 + Constants.padding) * CGFloat(index), y: 0, width: 15, height: 15)
      )
      starImageView.image = UIImage(named: "filledStar")
      let emptyStarImageView = starImageView.copyView() as! UIImageView
      emptyStarImageView.image = UIImage(named: "star")
      starImageViews.append(starImageView)
      addSubview(emptyStarImageView)
      addSubview(starImageView)
      self.translatesAutoresizingMaskIntoConstraints = false

      if index == 0 {
        let top = topAnchor.constraint(equalTo: starImageView.topAnchor, constant: 0)
        let bottom = bottomAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 0)
        let start = trailingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 0)
        addConstraints([top, bottom, start])
      } else if index == starCount - 1 {
        let right = rightAnchor.constraint(equalTo: starImageView.rightAnchor, constant: 0)
        addConstraint(right)
      }
    }
  }
}

extension StarRatingView: StarReatingViewing {
  func setRate(rating: Double) {
    if starImageViews.isEmpty {
      setUp()
    }
    
    let ratingBasedOnStarCount = Double(rating)/Double(scale/starCount)

    for index in 0..<starImageViews.count {
      let imageView = starImageViews[index]

      if ratingBasedOnStarCount >= Double(index + 1) {
        imageView.layer.mask = nil
        imageView.isHidden = false
      } else if ratingBasedOnStarCount > Double(index) && ratingBasedOnStarCount < Double(index + 1) {
        // Create a mask layer for full image
        let maskLayer = CALayer()
        // Calculate the mask width as a fraction of the full image
        let maskWidth = CGFloat(ratingBasedOnStarCount - Double(index)) * imageView.frame.size.width
        let maskHeight = imageView.frame.size.height
        // Set the mask frame
        maskLayer.frame = CGRect(x: 0, y: 0, width: maskWidth, height: maskHeight)
        // The mask layer needs a colour to show the full image
        maskLayer.backgroundColor = UIColor.black.cgColor
        // Set the full image view's mask and unhide it
        imageView.layer.mask = maskLayer
        imageView.isHidden = false
      }
      // Hide the full rating image if rating is less than index
      else {
        imageView.layer.mask = nil
        imageView.isHidden = true
      }
    }
  }
}

extension UIView {
  func copyView() -> AnyObject {
    return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self))! as AnyObject
  }
}
