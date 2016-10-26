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
  
  override func value(code: CodeContainer) -> String {
    guard children.count > 0 else { return "" }
    
    if children.count == 1 {
      // Dealing with a parenthetical, return it up the chain to be
      // used by something that performs some sort of operation or
      // calculation.
      return children[0].value(code: code)
    } else {
      // Dealing with a value + expression. The (+ expression) part may not
      // even exist, so we might just need to bubble a value up.
      let value = children[0].value(code: code)
      let opValue = children[1].value(code: code)
      if opValue != "" {
        let v = code.pushVar()
        code.append(v + " = " + value + " + " + opValue)
        code.popVar()
        return v
      } else {
        return value
      }
    }
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
