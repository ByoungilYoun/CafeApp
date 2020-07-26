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
  
//  var cafeProvider : CafeProvider!
  var cafeProvider = CafeProvider()
  
  private var filteredCafe : [Cafe] = []
  private var isFiltering : Bool {
    let isEmptyText = searchController.searchBar.text?.isEmpty ?? true
    return searchController.isActive && !isEmptyText
  }
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .systemBackground
    setNavigation()
    setUI()
    setConstraint()
    
  }
  
  //MARK: - struct
  struct Standard {
    static let standard : CGFloat = 10
    static let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
    
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "검색"
    searchController.searchResultsUpdater = self
    navigationItem.searchController = searchController
    definesPresentationContext = true
    
    
  }
  
  //MARK: - setUI()
  private func setUI() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
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
    return isFiltering ? filteredCafe.count : cafeProvider.list.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
    let cafe = isFiltering ? filteredCafe[indexPath.item] : cafeProvider.list[indexPath.item]
    
    cell.configure(image: UIImage(named: cafe.title), title: cafe.title, description: cafe.description, isFavorite: cafe.isFavorite, favoriteActionHandler: favoriteActionHandler(cell:isFavorite:))
    
    
    return cell
  }
  
  //MARK: - favoriteActionHandler 
  private func favoriteActionHandler (cell : UICollectionViewCell, isFavorite : Bool) {
    guard let indexPath = collectionView.indexPath(for: cell) else {return}
    cafeProvider.toggleFavoriteCafe(at: indexPath.item)
    guard let index = !isFiltering ? indexPath.item : cafeProvider.list.firstIndex(of: filteredCafe[indexPath.item]) else {return}
    cafeProvider.toggleFavoriteCafe(at: index)
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout 
extension HomeViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Standard.standard
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    Standard.standard
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    Standard.inset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width - Standard.inset.left - Standard.inset.right - Standard.standard
    let cellSize = width / 2
    return CGSize(width: cellSize, height: cellSize)
  }
}

//MARK: - UISearchResultsUpdating
extension HomeViewController : UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces) {
      filteredCafe = cafeProvider.filteredList(by: [text])
    } else {
      filteredCafe.removeAll()
    }
    collectionView.reloadData()
  }
}
