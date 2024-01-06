//
//  Assemble+Extension.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation
import Swinject

extension Assembler {
  
  static var shared: Assembler = {
    let container = Container()
    return Assembler([
      ServiceAssemble(),
    ], container: container)
  }()
  
}
