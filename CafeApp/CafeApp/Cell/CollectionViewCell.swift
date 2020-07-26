//
//  CollectionViewCell.swift
//  CafeApp
//
//  Created by 윤병일 on 2020/07/20.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class CollectionViewCell : UICollectionViewCell {
  //MARK: - Properties
  static let identifier = "CollectionViewCell"
  private let imageView = UIImageView()
  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  let heartButton = UIButton()
  
  private var favoriteActionHandler : ((CollectionViewCell, Bool) -> ())?
  //MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .systemBackground
    setUI()
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - setUI()
  private func setUI() {
    imageView.contentMode = .scaleToFill
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    contentView.addSubview(imageView)
    
    heartButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
    heartButton.contentMode = .scaleAspectFit
    heartButton.tintColor = .white
    heartButton.addTarget(self, action: #selector(didTapFavoriteButton(_:)), for: .touchUpInside)
    contentView.addSubview(heartButton)
    
    titleLabel.textAlignment = .left
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    contentView.addSubview(titleLabel)
    
    descriptionLabel.textAlignment = .left
    descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
    contentView.addSubview(descriptionLabel)
  }
  
  //MARK: - setConstraint()
  private func setConstraint() {
    [imageView, titleLabel, descriptionLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
      
    }
    
    heartButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
      
      heartButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5),
      heartButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
      heartButton.widthAnchor.constraint(equalToConstant: 20),
      heartButton.heightAnchor.constraint(equalToConstant: 20),
      
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
      
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      descriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
    ])
  }
  
  //MARK: - @objc func didTapFavoriteButton
  @objc private func didTapFavoriteButton (_ sender : UIButton) {
    sender.isSelected.toggle()
    UIView.animate(withDuration: 0.35) {
      sender.tintColor = sender.isSelected ? .systemPink : .white
    }
    favoriteActionHandler!(self, sender.isSelected)
  }
  
  //MARK: - Configure Cell
  func configure(
    image : UIImage?,
    title : String?,
    description : String?,
    isFavorite : Bool = false,
    favoriteActionHandler :
    ((CollectionViewCell, Bool) -> ())? = nil
  ) {
    imageView.image = image
       titleLabel.text = title
       descriptionLabel.text = description
       heartButton.isSelected = isFavorite
       heartButton.tintColor = isFavorite ? .systemPink : .white
       self.favoriteActionHandler = favoriteActionHandler
  }
}
