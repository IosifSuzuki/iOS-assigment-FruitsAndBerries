//
//  EndpointRequest.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation
import Alamofire

class EndpointRequest: URLRequestConvertible {
  
  let configuration: Configuration
  let endpoint: EndpointConfigurable
  
  var jsonEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    encoder.outputFormatting = .prettyPrinted
    
    return encoder
  }()
  
  init(configuration: Configuration, endpoint: EndpointConfigurable) {
    self.configuration = configuration
    self.endpoint = endpoint
  }
  
  func asURLRequest() throws -> URLRequest {
    var endpointURL = configuration.baseURL
    endpointURL.append(path: endpoint.path)
    endpointURL.append(queryItems: endpoint.queryParams)
    
    var request = URLRequest(url: endpointURL, cachePolicy: .reloadIgnoringLocalCacheData)
    request.headers = HTTPHeaders(endpoint.header.map { (key: String, value: String) in
      HTTPHeader(name: key, value: value)
    })
    
    if let body = endpoint.body {
      let bodyData = try jsonEncoder.encode(body)
      request.httpBody = bodyData
    }
    
    return request
  }
  
}
