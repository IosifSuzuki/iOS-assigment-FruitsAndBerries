//
//  APIOperation.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

protocol API {
  
  func fetchGrosary() async throws -> Grocery
  func fetchGrosaryProduct(by id: String) async throws -> GroceryProductDetail
  func icon(path: String?) -> URL?
  
}
