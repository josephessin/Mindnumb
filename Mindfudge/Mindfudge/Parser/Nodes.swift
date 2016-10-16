//
//  Nodes.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/15/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// Represents an error encountered while creating the abstract syntax tree.
enum ParseError: Error {
  /// An invalid token was encountered.
  case invalidToken(found: Token)
}

/// Implemented by CFG rule nodes so that they can apply the right production
/// rule when given the current token.
protocol VariableNode {
  
  /// Load the appropriate child nodes based upon the predict rules, given
  /// the current token.
  func loadChildren(fromLookAhead token: Token) throws
}

/// Represents a node in an abstract syntax tree.
/// Do not initialize this class directly, instead use TerminalNode
/// or a node class that implements loadChildren.
class Node {
  
  /// The node's children.
  /// The left-most node is considered to be the first element, [0].
  var children: [Node] = []
}

class Terminal: Node {
  
  /// The token representing the terminal node's value.
  fileprivate(set) var token: Token
  
  /// Creates a new terminal node with the specified token value.
  init(token: Token) {
    self.token = token
  }
}

/// Represents the <block> variable in the CFG for Mindfudge.
class Block: Node, VariableNode {
  /// Represents identifiers used in the predict rules.
  private static let ids = ["set", "left", "right", "add", "sub", "printA",
                            "printI", "inputA", "inputI", "make", "remove",
                            "jump", "while", "if", "die"]
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case .newline:
      rule1()
    case let .id(string) where Block.ids.contains(string):
      rule1()
    case .eof:
      rule2()
    default:
      throw
        ParseError.invalidToken(found: token)
    }
  }
  
  /// Rule 1: <block> ::= <command> <newline> <block>
  private func rule1() {
    children += [Command(), Terminal(token: .newline), Block()]
  }
  
  /// Rule 2: <block> ::= !
  private func rule2() { }
}

/// Represents the <command> variable in the CFG for Mindfudge.
class Command: Node, VariableNode {
  
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
                 Terminal(token: .id),
                 Terminal(token: .comma),
                 Expression(),
                 Terminal(token: .parenthesisClose)]
  }
  
  /// <command> ::= 'remove' '(' <id> ')'
  private func rule11() {
    children += [Terminal(token: .id("remove")),
                 Terminal(token: .parenthesisOpen),
                 Expression(),
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

