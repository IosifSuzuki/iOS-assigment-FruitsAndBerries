//
//  Grocery.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

struct Grocery: Decodable {
  let title: String
  let items: [GroceryProduct]
  
  enum CodingKeys: String, CodingKey {
    case title
    case items
  }
  
}
