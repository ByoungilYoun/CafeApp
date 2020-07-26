//
//  CafeProvider.swift
//  CafeApp
//
//  Created by 윤병일 on 2020/07/26.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation

final class CafeProvider {
  var list : [Cafe] = try! JSONDecoder().decode(type: [Cafe].self, from: "CafeList.json")
  
  func toggleFavoriteCafe(at index : Int) {
    list[index].isFavorite.toggle()
  }
}
