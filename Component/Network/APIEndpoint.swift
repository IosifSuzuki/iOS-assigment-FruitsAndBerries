//
//  APIEndpoint.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

enum APIEndpoint: EndpointConfigurable {
  
  case grocery
  
  var method: HTTPMethod {
    switch self {
    case .grocery:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .grocery:
      "/items/random"
    }
  }
  
  var queryParams: [URLQueryItem] {
    switch self {
    case .grocery:
      []
    }
  }
  
  var header: [String : String] {
    switch self {
    case .grocery:
      [:]
    }
  }
  
  var body: Encodable? {
    switch self {
    case .grocery:
      nil
    }
  }
  
}
