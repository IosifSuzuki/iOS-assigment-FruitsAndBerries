//
//  EndpointConfigurable.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation
import Alamofire

enum HTTPMethod {
  case get
  case delete
  case put
  case post
  
  var afMethod: Alamofire.HTTPMethod {
    switch self {
    case .get:
      return .get
    case .delete:
      return .delete
    case .put:
      return .put
    case .post:
      return .post
    }
  }
}

protocol EndpointConfigurable {
  var method: HTTPMethod { get }
  var path: String { get }
  var queryParams: [URLQueryItem] { get }
  var header: [String: String] { get }
  var body: Encodable? { get }
}
