//
//  Expression.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class Expression: Node, Variable {
  
  override var description: String {
    return "Expression"
  }
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case .integer, .id:
      rule1()
    case .parenthesisOpen:
      rule2()
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  /// <expression> ::= <value> <operation>
  private func rule1() {
    children += [Value(), Operation()]
  }
  
  /// <expression> :: = <parenthetical>
  private func rule2() { children += [Parenthetical()] }
  
}
