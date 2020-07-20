//
//  HomeViewController.swift
//  CafeApp
//
//  Created by 윤병일 on 2020/07/20.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController {
  //MARK: - Property
  private var searchController = UISearchController (searchResultsController: nil)
  
  private var collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setUI()
    setConstraint()
    
  }
  
  //MARK: - setNavigation()
  private func setNavigation() {
    let titleLabel = UILabel()
    titleLabel.textAlignment = .center
    titleLabel.attributedText  = NSAttributedString(
      string: "CafeSpot",
      attributes: [
        NSAttributedString.Key.font : UIFont(name: "Zapfino", size: 16)!,
        NSAttributedString.Key.kern : 5
      ]
    )
     navigationItem.titleView = titleLabel
    
    searchController.obscuresBackgroundDuringPresentation = false // 표시된 뷰를 흐리게 하기. 현재뷰를 흐리게 하지 않고 싶은것.
    searchController.searchBar.placeholder = "검색"
    navigationItem.searchController = searchController
    definesPresentationContext = true // UISearchController 가 활성되어 있는 동안 사용자가 다른 뷰 컨트롤러로 이동하면 search bar 가 화면에 남아 있지 않도록 한다.
    
    
  }
  
  //MARK: - setUI()
  private func setUI() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    view.addSubview(collectionView)
  }
  
  //MARK: - setConstraint()
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
    ])
  }
}

  //MARK: - UICollectionViewDataSource
extension HomeViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}


extension HomeViewController : UICollectionViewDelegateFlowLayout {
  
}
