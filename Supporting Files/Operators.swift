//
//  Operators.swift
//  iOS-Test
//
//  Created by Bogdan Petkanych on 06.01.2024.
//

import Foundation

precedencegroup FunctionApplicationPrecedence {
  associativity: left
  higherThan: BitwiseShiftPrecedence
}

infix operator &>: FunctionApplicationPrecedence

@discardableResult
public func &> <Input>(value: Input, function: (inout Input) throws -> Void) rethrows -> Input {
  var m_value = value
  try function(&m_value)
  return m_value
}
