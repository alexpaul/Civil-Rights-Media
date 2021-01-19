//
//  HeaderView.swift
//  CivilRightsMedia
//
//  Created by Alex Paul on 1/18/21.
//

import UIKit

class HeaderView: UICollectionReusableView {
  static let reuseIdentifier = "headerView"
  
  private lazy var images: [UIImage] = [UIImage(named: "mlk")!, UIImage(named: "medgar-evers")!, UIImage(named: "john-lewis")!,
                                        UIImage(named: "thurgood-marshall")!]
  
  public lazy var imageView: UIImageView = {
    let iv = UIImageView()
    iv.image = images.randomElement() ?? UIImage(systemName: "photo")
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
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
  }
  
  private func imageViewConstraints() {
    addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
