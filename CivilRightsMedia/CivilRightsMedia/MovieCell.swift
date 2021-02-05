//
//  MovieCell.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/17/21.
//

import UIKit

class MovieCell: UICollectionViewCell {
  static let reuseIdentifier = "movieCell"
  
  private let padding: CGFloat = 16
  
  public var overviewLabel: UILabel = {
    let label = UILabel()
    label.text = "Overview of the movie goes heer."
    label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(18)
    label.numberOfLines = 0
    return label
  }()
  
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
    overviewLabelConstraints()
    layer.cornerRadius = 10
    layer.masksToBounds = true
  }
  
  private func imageViewConstraints() {
    addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
    ])
  }
  
  private func overviewLabelConstraints() {
    addSubview(overviewLabel)
    overviewLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      overviewLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
      overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      overviewLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -padding),
      overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
    ])
  }
  
}

