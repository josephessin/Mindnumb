//
//  Program.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class Program: Node, Variable {
  
  private static let ids = ["set", "left", "right", "add", "sub", "printA",
                            "printI", "inputA", "inputI", "make", "remove",
                            "jump", "while", "if", "die"]
  
  func loadChildren(fromLookAhead token: Token) throws {
    switch token {
    case .newline, .eof:
      rule1()
    case let .id(string) where Program.ids.contains(string):
      rule1()
    default:
      throw SyntaxError.invalidToken(found: token)
    }
  }
  
  /// <program> ::= <block> <EOF>
  private func rule1() {
    children += [Block(), Terminal(token: .eof)]
  }
}
