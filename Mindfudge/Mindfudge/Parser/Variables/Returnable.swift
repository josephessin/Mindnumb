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
  
  override func value(code: CodeContainer) -> String {
    guard children.count > 0 else { return "" }
    
    let comp = children[0] as! Terminal
    
    if case .id(let id) = comp.token {
      switch id {
      case "get":
        let v = code.pushVar()
        code.append(v + " = " + children[1].value(code: code))
        code.popVar()
        return v
      case "not":
        let vnot = children[1].value(code: code)
        code.append(vnot + " = 0 if (" + vnot + " != 0) else 1 #not")
        return vnot
      case "eq", "or", "gt", "ge", "lt", "le":
        let v1 = children[2].value(code: code)
        let va = code.pushVar()
        code.append(va + " = " + v1)
        let v2 = children[4].value(code: code)
        let vb = code.pushVar()
        code.append(vb + " = " + v2)
        code.popVar()
        code.popVar()
        
        switch id {
        case "eq":
          code.append(va + " = 1 if (" + va + " == " + vb + ") else 0 #eq")
        case "or":
          code.append(va + " = 1 if ((" + va + " == 1) or (" + vb + " == 1)) else 0 #or")
        case "gt":
          code.append(va + " = 1 if (" + va + " > " + vb + ") else 0 #gt")
        case "ge":
          code.append(va + " = 1 if (" + va + " >= " + vb + ") else 0 #ge")
        case "lt":
          code.append(va + " = 1 if (" + va + " < " + vb + ") else 0 #lt")
        case "le":
          code.append(va + " = 1 if (" + va + " <= " + vb + ") else 0 #le")
        default:
          break
        }
        
        return va
        
      default:
        break
      }
    }
    return "error in returnable"
  }
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case let .id(string) where string == "get" || string == "not":
      rule1(singleOp: string)
    case let .id(string) where
      string == "eq" || string == "gt" || string == "ge" || string == "lt"
        || string == "le" || string == "or":
      ruleBuiltInFunction(id: string)
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  // <returnable> ::= 'get' <parenthetical>)
  /// <returnable> ::= 'not' '(' <expression> ')'
  private func rule1(singleOp: String) {
    children += [Terminal(token: .id(singleOp)), Parenthetical()]
  }
  
  
  /// <returnable> ::= 'eq' '(' <expression> ',' <expression> ')'
  /// <returnable> ::= 'or' '(' <expression> ',' <expression> ')'
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
