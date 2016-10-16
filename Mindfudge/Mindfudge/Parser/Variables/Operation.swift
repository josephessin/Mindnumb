//
//  Operation.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class Operation: Node, Variable {
  
  override var description: String {
    return "Operation"
  }
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case let .op(str) where str == "+":
      rule1()
    case .parenthesisClose, .comma:
      rule2()
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  /// <operation> ::= '+' <expression>
  private func rule1() {
    children += [Terminal(token: .op("+")), Expression()]
  }
  
  /// <operation> ::= !
  private func rule2() { }
  
}
