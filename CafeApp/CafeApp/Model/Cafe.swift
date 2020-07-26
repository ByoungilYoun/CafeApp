//
//  Cafe.swift
//  CafeApp
//
//  Created by 윤병일 on 2020/07/26.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation

struct Cafe : Codable {
  let title : String
  let description : String
  let location : Location
  let isFavorite : Bool
  
  struct Location : Codable {
    let address : String
    let lat : Double
    let lng : Double
  }
  
}
