//
//  Identify.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

protocol Identify {
  static var identifier: String { get }
}

extension Identify {
  
  static var identifier: String {
    return String(describing: Self.self)
  }
  
}
