//
//  Program.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class Program: Node, Variable {
  
  override var description: String {
    return "Program"
  }

  override func value(code: CodeContainer) -> String {
    code.append("import sys")
    code.append("def main():")
    code.indent()
    code.append("index = 0")
    code.append("v0 = 0")
    code.append("v1 = 0")
    code.append("memory = []")
    code.append("for i in range(0, 30000):")
    code.indent()
    code.append("memory.append(0)")
    code.unindent()
    _ = children[0].value(code: code)
    code.unindent()
    code.append("if __name__ == \"__main__\":")
    code.indent()
    code.append("main()")
    code.unindent()
    return ""
  }
  
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
