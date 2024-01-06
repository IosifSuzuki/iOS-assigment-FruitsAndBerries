//
//  AppConfiguration.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

struct AppConfiguration: Configuration, Identify {
  
  // MARK: - Configuration
  
  var baseURL: URL {
    let url: URL
    do {
      let urlText: String = try Self.value(for: .baseURL)
      guard let unwrapURL = URL(string: urlText) else {
        throw ApplicationError(reason: "baseURL contains not url value")
      }
      url = unwrapURL
    } catch {
      fatalError(error.localizedDescription)
    }
    return url
  }
  
  static func value<T>(for key: KeyPath) throws -> T where T: LosslessStringConvertible {
    guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
      throw ApplicationError(reason: "missing configuration key")
    }
    
    switch object {
    case let value as T:
      return value
    case let string as String:
      guard let value = T(string) else { fallthrough }
      return value
    default:
      throw ApplicationError(reason: "unknwon value by configuration keypath: \(key.rawValue)")
    }
  }
  
  enum KeyPath: String {
    case baseURL = "BASE_API_URL"
  }
}
