//
//  Block.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// Represents the <block> variable in the CFG for Mindfudge.
class Block: Node, Variable {
  
  override var description: String {
    return "Block"
  }
  
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
    case let .id(string) where string == "end":
      // Block goes to nil if we see the follow of block,
      // which also contains "end"
      rule2()
    default:
      throw
        SyntaxError.invalidToken(found: token)
    }
  }
  
  /// <block> ::= <command> <newline> <block>
  private func rule1() {
    children += [Command(), Terminal(token: .newline), Block()]
  }
  
  /// <block> ::= !
  private func rule2() { }
}
