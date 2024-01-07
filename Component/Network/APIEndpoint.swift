//
//  APIEndpoint.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

enum APIEndpoint: EndpointConfigurable {
  
  case grocery
  case groceryProduct(id: String)
  
  var method: HTTPMethod {
    switch self {
    case .grocery:
        .get
    case .groceryProduct:
        .get
    }
  }
  
  var path: String {
    switch self {
    case .grocery:
      "/items/random"
    case let .groceryProduct(id: id):
      "/texts/\(id)"
    }
  }
  
  var queryParams: [URLQueryItem] {
    switch self {
    case .grocery:
      []
    case .groceryProduct:
      []
    }
  }
  
  var header: [String : String] {
    switch self {
    case .grocery:
      [:]
    case .groceryProduct:
      [:]
    }
  }
  
  var body: Encodable? {
    switch self {
    case .grocery:
      nil
    case .groceryProduct:
      nil
    }
  }
  
}
