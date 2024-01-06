//
//  Data+Extension.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

extension Data {
  
  var prettyJSONString: String? {
    guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
          let prettyJSONString = String(data: data, encoding: .utf8) else {
      return nil
    }
    
    return prettyJSONString
  }
  
}
