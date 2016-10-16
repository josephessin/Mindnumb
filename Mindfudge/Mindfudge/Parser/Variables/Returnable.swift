//
//  Returnable.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class Returnable: Node, Variable {
  
  override var description: String {
    return "Returnable"
  }
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case let .id(string) where string == "get":
      rule1()
    case let .id(string) where
      string == "eq" || string == "gt" || string == "ge" || string == "lt"
      || string == "le":
      ruleBuiltInFunction(id: string)
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  // <returnable> ::= 'get' <parenthetical>)
  private func rule1() {
    children += [Terminal(token: .id("get")), Parenthetical()]
  }
  
  /// <returnable> ::= 'eq' '(' <expression> ',' <expression> ')'
  /// <returnable> ::= 'gt' '(' <expression> ',' <expression> ')'
  /// <returnable> ::= 'ge' '(' <expression> ',' <expression> ')'
  /// <returnable> ::= 'lt' '(' <expression> ',' <expression> ')'
  /// <returnable> ::= 'le' '(' <expression> ',' <expression> ')'
  /// - Parameter id: The built in function. Must be 'eq', 'gt', 'ge',
  ///   'lt', or 'le'.
  private func ruleBuiltInFunction(id: String) {
    children += [Terminal(token: .id(id)),
                 Terminal(token: .parenthesisOpen),
                 Expression(),
                 Terminal(token: .comma),
                 Expression(),
                 Terminal(token: .parenthesisClose)]
  }
}
