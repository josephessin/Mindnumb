//
//  Parenthetical.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class Parenthetical: Node, Variable {
  
  override var description: String {
    return "Parenthetical"
  }
  
  override func value(code: CodeContainer) -> String {
    return children[1].value(code: code)
  }
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case .parenthesisOpen:
      rule1()
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  /// <parenthetical> ::= '(' <expression> ')'
  private func rule1() {
    children += [Terminal(token: .parenthesisOpen),
                 Expression(),
                 Terminal(token: .parenthesisClose)]
  }
  
}
