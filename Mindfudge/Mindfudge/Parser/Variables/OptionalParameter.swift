//
//  OptionalParameter.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class OptionalParameter: Node, Variable {
  
  override var description: String {
    return "OptionalParameter"
  }
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case .parenthesisOpen:
      rule1()
    case .newline:
      rule2()
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  /// <optionalParameter> ::= <parenthetical>
  private func rule1() { children += [Parenthetical()] }
  
  /// <optionalParameter> ::= !
  private func rule2() { }
}
