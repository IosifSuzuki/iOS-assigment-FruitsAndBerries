//
//  NetworkOperation.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation
import Alamofire
import Swinject

final class NetworkOperation {
  
  let configuration: Configuration
  let session: Session
  let dispatchQueue: DispatchQueue
  
  var jsonDecoder: JSONDecoder {
    let jsonDecoder = JSONDecoder()
    
    return jsonDecoder
  }
  
  init(configuration: Configuration, eventMonitor: LoggerEventMonitor) {
    self.configuration = configuration
    self.dispatchQueue = DispatchQueue.global(qos: .background)
    self.session = Session(eventMonitors: [eventMonitor])
  }
  
}

// MARK: - Private
private extension NetworkOperation {
  
  func endpointRequest(endpoitConfigurable: EndpointConfigurable) -> EndpointRequest {
    EndpointRequest(configuration: configuration, endpoint: endpoitConfigurable)
  }
  
  private func performRequest<T: Decodable>(endpoint: URLRequestConvertible, jsonDecoder: JSONDecoder) async throws -> T {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self else {
        continuation.resume(throwing: ApplicationError(reason: "nil value"))
        return
      }
      session.request(endpoint)
        .validate(statusCode: 200..<300)
        .response { resp in
          guard let response = resp.response else {
            continuation.resume(throwing: ApplicationError(reason: "response unset"))
            return
          }
          guard let bodyData = resp.data else {
            continuation.resume(throwing: ApplicationError(reason: "status code: \(response.statusCode), response contains an empty body"))
            return
          }
          
          let result: T
          do {
            result = try jsonDecoder.decode(T.self, from: bodyData)
          } catch {
            print("json decoded occured error: \(error)")
            continuation.resume(throwing: error)
            return
          }
          continuation.resume(returning: result)
        }
        .resume()
    }
  }
  
}

// MARK: - APIOperation
extension NetworkOperation: API {
  
  func fetchGrosary() async throws -> Grocery {
    let endpoint = endpointRequest(endpoitConfigurable: APIEndpoint.grocery)
    
    return try await performRequest(endpoint: endpoint, jsonDecoder: jsonDecoder)
  }
  
  func fetchGrosaryProduct(by id: String) async throws -> GroceryProductDetail {
    let endpoint = endpointRequest(endpoitConfigurable: APIEndpoint.groceryProduct(id: id))
    
    return try await performRequest(endpoint: endpoint, jsonDecoder: jsonDecoder)
  }
  
  func icon(path: String?) -> URL? {
    guard let path else {
      return nil
    }
    
    return configuration.baseURL.appending(path: path)
  }

  
}
