//
//  Terminal.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class Terminal: Node {
  
  /// The token representing the terminal node's value.
  fileprivate(set) var token: Token
  
  /// List of reserved words in Mindfudge.
  private static let reserved: [String] = ["set", "left", "right", "add", "sub",
                                           "printA", "printI", "inputA",
                                           "inputI", "make", "remove", "jump",
                                           "while", "if", "die", "eq", "or",
                                           "gt", "ge", "lt", "le", "get"]
  
  override func value(code: CodeContainer) -> String {
    switch token {
    case .id(let string):
      if Terminal.reserved.contains(string) {
        return string
      } else if string == "indexValue" {
        return "memory[index]"
      }else {
        // We need to use the python runtime library to find the address of the
        // specified array identifier
        return "address(\"\(string)\")"
      }
    case .integer(let string):
      return string
    case .op(let string):
      return string
    case .comma:
      return ","
    default:
      return ""
    }
  }
  
  /// Creates a new terminal node with the specified token value.
  init(token: Token) {
    self.token = token
  }
  
  override var description: String {
    return token.description
  }
}
