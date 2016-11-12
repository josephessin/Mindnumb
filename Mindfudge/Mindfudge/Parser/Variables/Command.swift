//
//  Command.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// Represents the <command> variable in the CFG for Mindfudge.
class Command: Node, Variable {
  
  override var description: String {
    return "Command"
  }
  
  override func value(code: CodeContainer) -> String {
    guard children.count > 0 else { return "" }
    
    if let comp = children[0] as? Terminal {
      
      if case .id(let id) = comp.token {
        switch id {
        case "set":
          code.append("memory[index] = " + children[2].value(code: code))
        case "left":
          let optional = children[1].value(code: code)
          if optional == "" {
            code.append("index = index - 1 if index > 0 else index")
          } else {
            code.append("index = (index - " + optional +
              ") if (index > 0) else index")
          }
        case "right":
          let optional = children[1].value(code: code)
          if optional == "" {
            code.append("index = (index + 1) if (index < 29999) else index")
          } else {
            code.append("index = (index + " + optional +
              ") if (index < 29999) else index")
          }
        case "add":
          let optional = children[1].value(code: code)
          if optional == "" {
            code.append("memory[index] += 1")
          } else {
            code.append("memory[index] += " + optional)
          }
        case "sub":
          let optional = children[1].value(code: code)
          if optional == "" {
            code.append("memory[index] -= 1")
          } else {
            code.append("memory[index] -= " + optional)
          }
        case "printA":
          code.append("print(chr(memory[index]))")
        case "printI":
          code.append("print(memory[index])")
        case "inputA":
          code.append("memory[index] = ord(input(\"Type a character: \")[0])")
        case "inputI":
          code.append("memory[index] = int(input(\"Type an integer: \")[0])")
        case "make":
          code.append("malloc(\"" + children[2].value(code: code) + "\", " +
            children[4].value(code: code) + ")")
        case "remove":
          code.append("free(\"" + children[2].value(code: code) + "\")")
        case "jump":
          code.append("index = " + children[1].value(code: code))
        case "while":
          code.append("while (" + children[1].value(code: code) + " != 0):")
          code.indent()
          _ = children[3].value(code: code)
          _ = children[1].value(code: code) // re-prime the while loop
          code.unindent()
        case "if":
          code.append("if (" + children[1].value(code: code) + " != 0):")
          code.indent()
          _ = children[3].value(code: code)
          code.unindent()
        case "die":
          code.append("sys.exit()")
        default:
          return ""
        }
      }
    }
    return ""
  }
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case let .id(string) where string == "set":
      rule1()
    case let .id(string) where string == "left":
      rule2()
    case let .id(string) where string == "right":
      rule3()
    case let .id(string) where string == "add":
      rule4()
    case let .id(string) where string == "sub":
      rule5()
    case let .id(string) where string == "printA":
      rule6()
    case let .id(string) where string == "printI":
      rule7()
    case let .id(string) where string == "inputA":
      rule8()
    case let .id(string) where string == "inputI":
      rule9()
    case let .id(string) where string == "make":
      rule10()
    case let .id(string) where string == "remove":
      rule11()
    case let .id(string) where string == "jump":
      rule12()
    case let .id(string) where string == "while":
      rule13()
    case let .id(string) where string == "if":
      rule14()
    case let .id(string) where string == "die":
      rule15()
    case .newline:
      rule16()
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  /// <command> ::= 'set' '(' <expression> ')'
  private func rule1() {
    children += [Terminal(token: .id("set")), Terminal(token: .parenthesisOpen),
                 Expression(), Terminal(token: .parenthesisClose)]
  }
  
  /// <command> ::= 'left' <optionalParameter>
  private func rule2() {
    children += [Terminal(token: .id("left")), OptionalParameter()]
  }
  
  /// <command> ::= 'right' <optionalParameter>
  private func rule3() {
    children += [Terminal(token: .id("right")), OptionalParameter()]
  }
  
  /// <command> ::= 'add' <optionalParameter>
  private func rule4() {
    children += [Terminal(token: .id("add")), OptionalParameter()]
  }
  
  /// <command> ::= 'sub' <optionalParameter>
  private func rule5() {
    children += [Terminal(token: .id("sub")), OptionalParameter()]
  }
  
  /// <command> ::= 'printA'
  private func rule6() { children += [Terminal(token: .id("printA"))] }
  /// <command> ::= 'printI'
  private func rule7() { children += [Terminal(token: .id("printI"))] }
  /// <command> ::= 'inputA'
  private func rule8() { children += [Terminal(token: .id("inputA"))] }
  /// <command> ::= 'inputI'
  private func rule9() { children += [Terminal(token: .id("inputI"))] }
  
  /// <command> ::= 'make' '(' <id> ',' <expression> ')'
  private func rule10() {
    children += [Terminal(token: .id("make")),
                 Terminal(token: .parenthesisOpen),
                 Identifier(),
                 Terminal(token: .comma),
                 Expression(),
                 Terminal(token: .parenthesisClose)]
  }
  
  /// <command> ::= 'remove' '(' <id> ')'
  private func rule11() {
    children += [Terminal(token: .id("remove")),
                 Terminal(token: .parenthesisOpen),
                 Identifier(),
                 Terminal(token: .parenthesisClose)]
  }
  
  /// <command> ::= 'jump' <parenthetical>
  private func rule12() {
    children += [Terminal(token: .id("jump")), Parenthetical()]
  }
  
  /// <command> ::= 'while' <parenthetical> <newline> <block> <end>
  private func rule13() {
    children += [Terminal(token: .id("while")),
                 Parenthetical(),
                 Terminal(token: .newline),
                 Block(),
                 Terminal(token: .id("end"))]
  }
  
  /// <command> ::= 'if' <parenthetical> <newline> <block> <end>
  private func rule14() {
    children += [Terminal(token: .id("if")),
                 Parenthetical(),
                 Terminal(token: .newline),
                 Block(),
                 Terminal(token: .id("end"))]
  }
  
  /// <command> ::= 'die'
  private func rule15() { children += [Terminal(token: .id("die"))] }
  
  /// <command> ::= !
  private func rule16() { }
}
