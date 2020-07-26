//
//  MainController.swift
//  CafeApp
//
//  Created by 윤병일 on 2020/07/20.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
  
  //MARK: - viewDidLoad() 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
    
    let mapVC = UINavigationController(rootViewController: MapViewController())
    mapVC.tabBarItem = UITabBarItem(title: "지도 검색", image: UIImage(systemName: "map.fill"), tag: 1)
    
    viewControllers = [homeVC, mapVC]
  }
}
