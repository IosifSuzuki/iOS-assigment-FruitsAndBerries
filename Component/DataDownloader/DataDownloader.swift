//
//  DataDownloader.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

final class DataDownloader: Downloader {
  
  private var dataTask: URLSessionDataTask?
  
  func fetch(by url: URL, closure: @escaping (Result<Data, ApplicationError>) -> Void) {
    let request = URLRequest(url: url)
    
    cancel()
    dataTask = URLSession(configuration: .default)
      .dataTask(with: request, completionHandler: { data, resp, err in
        guard let httpResp = resp as? HTTPURLResponse else {
          closure(.failure(ApplicationError(reason: "unknown response")))
          return
        }
        
        guard (200..<300).contains(httpResp.statusCode) else {
          closure(.failure(ApplicationError(reason: "failure code: \(httpResp.statusCode)")))
          return
        }
        
        guard let data else {
          closure(.failure(ApplicationError(reason: "empty data")))
          return
        }
        
        closure(.success(data))
      })
  }
  
  
  func cancel() {
    dataTask?.cancel()
  }
  
  func resume() {
    dataTask?.resume()
  }
  
}
