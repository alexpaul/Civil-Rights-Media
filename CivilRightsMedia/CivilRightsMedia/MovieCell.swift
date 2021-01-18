//
//  MovieCell.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/17/21.
//

import UIKit


import UIKit

class MovieCell: UICollectionViewCell {
  static let reuseIdentifier = "movieCell"
  
  public var imageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "photo.fill")
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    imageViewConstraints()
    layer.cornerRadius = 10
    layer.masksToBounds = true
  }
  
  private func imageViewConstraints() {
    addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
}

