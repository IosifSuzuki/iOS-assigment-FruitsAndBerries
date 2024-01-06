//
//  Item.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

struct GroceryProduct: Decodable {
  let id: String
  let name: String
  let image: String?
  let color: String
}
