//
//  ServiceAssemble.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation
import Swinject

class ServiceAssemble: Assembly {
  
  func assemble(container: Container) {
    container.register(Configuration.self, name: AppConfiguration.identifier) { _ in
      AppConfiguration()
    }
    container.register(API.self) { resolver in
      let configuration = resolver.resolve(Configuration.self, name: AppConfiguration.identifier)!
      
      return NetworkOperation(configuration: configuration, eventMonitor: LoggerEventMonitor())
    }
  }
  
}
