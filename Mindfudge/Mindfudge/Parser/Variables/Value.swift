//
//  Value.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class Value: Node, Variable {
  
  private static let firstOfReturnable = ["get", "eq", "gt", "ge", "lt", "le"]
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case let .id(str) where Value.firstOfReturnable.contains(str):
      rule1()
    case let .integer(str):
      rule2(intString: str)
    case let .id(str):
      rule3(idString: str)
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  /// <value> ::= <returnable>
  private func rule1() { children += [Returnable()] }
  
  /// <value> ::= <integer>
  /// - Parameter intString: The string value of the integer.
  private func rule2(intString: String) {
    children += [Terminal(token: .integer(intString))]
  }
  
  /// <value> ::= <id>
  /// - Parameter idString: The string value of the id.
  private func rule3(idString: String) {
    children += [Terminal(token: .id(idString))]
  }
}
