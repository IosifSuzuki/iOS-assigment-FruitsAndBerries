//
//  ApplicationError.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

struct ApplicationError: Error, LocalizedError {
  let reason: String
  
  var errorDescription: String? {
    return reason
  }

  var failureReason: String? {
    return reason
  }
  
  var localizedDescription: String {
    return reason
  }
  
}
