//
//  Identifier.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class Identifier: Node, Variable {
  
  override var description: String {
    return "Identifier"
  }
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case .id:
      rule1(id: token)
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  /// <identifier> ::= ('A'-'Z' | 'a'-'z') ('A'-'Z' | 'a'-'z' | '0'-'9')*
  private func rule1(id: Token) {
    children += [Terminal(token: id)]
  }
  
}
