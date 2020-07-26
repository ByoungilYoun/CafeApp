//
//  JSONDecoderExtension.swift
//  CafeApp
//
//  Created by 윤병일 on 2020/07/26.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation

extension JSONDecoder {
  func decode<T> (
    type : T.Type,
    from fileName : String
  ) throws -> T where T : Decodable {
    guard let jsonFileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
      fatalError("\(fileName) 파일이 존재하지 않습니다.")
    }
    let data = try Data(contentsOf: jsonFileURL)
    let decodeData = try JSONDecoder().decode(T.self, from: data)
    return decodeData
  }
}
