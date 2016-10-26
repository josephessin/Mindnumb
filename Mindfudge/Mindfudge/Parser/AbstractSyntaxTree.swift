//
//  AbstractSyntaxTree.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class AbstractSyntaxTree {
  
  /// The root of the tree.
  fileprivate(set) var root: Node = Program()
  
  fileprivate var index: Int = 0
  
  fileprivate var tokens: [Token]
  
  /// Creates an abstract syntax tree based on the sequence of tokens
  /// given to it.
  /// - Parameter tokens: The array of tokens to parse.
  init?(tokens: [Token]) throws {
    guard tokens.count > 0 else { return nil }
    self.tokens = tokens
    do {
      // Go ahead and make some predictions based on the first token:
      if let root = root as? Variable {
        Swift.print("Trying to load root's children with: " + tokens[index].description)
        try root.loadChildren(fromLookAhead: tokens[index])
        // We don't increment index here because <program>'s first child
        // is a variable, and we don't increment the token pointer
        // on a variable.
      }
    } catch let exception {
      throw exception
    }
  }
  
  /// Begins parsing.
  func parse() throws {
    try recursiveParse(node: root)
  }
  
  /// Prints the tree out!
  func print() {
    recursivePrint(node: root, string: "--")
  }
  
  /// Compiles python code for the syntax tree.
  func code() -> String {
    let code = CodeContainer()
    _ = root.value(code: code)
    return code.code
  }
  
  private func recursivePrint(node: Node, string: String) {
   // let head = "|" + String(repeating: "-", count: level * 2)
    let head = string + "*"
    let str = head + " " + node.description
    Swift.print(str)
    for child in node.children {
      recursivePrint(node: child, string: string + "|" + "--")
    }
  }
  
  private func recursiveParse(node: Node) throws {
    do {
      // Look through the children of the node, from left to right.
      for child in node.children {
        if child is Terminal {
          let terminal = child as! Terminal
          // If it's a terminal, check it with our input stream.
          let token = terminal.token
          
          Swift.print("Encountered terminal: " + token.description)
          
          // Compare the predicted token with the current token.
          // If they match, move the index up by one.
          switch (token, tokens[index]) {
          case (.id(let a), .id(let b)) where a == b:
            Swift.print("*Matched* identifier")
            index += 1
          case (.integer(let a), .integer(let b)) where a == b:
            Swift.print("*Matched* integer")
            index += 1
          case (.op(let a), .op(let b)) where a == b:
            Swift.print("*Matched* operator")
            index += 1
          case (.eof, .eof):
            Swift.print("*Matched* eof")
            index += 1
          case (.newline, .newline):
            Swift.print("*Matched* newline")
            index += 1
          case (.parenthesisOpen, .parenthesisOpen):
            Swift.print("*Matched* (")
            index += 1
          case (.parenthesisClose, .parenthesisClose):
            Swift.print("*Matched* )")
            index += 1
          case (.comma, .comma):
            Swift.print("*Matched* comma")
            index += 1
          default:
            throw SyntaxError.invalidToken(found: token)
          }
        } else if child is Variable {
          let variable = child as! Variable
          // Lazily load the node's children:
          try variable.loadChildren(fromLookAhead: tokens[index])
          // If that worked, enter recursion:
          Swift.print("Entering: " + variable.description)
          try recursiveParse(node: child)
        }
      }
    } catch let exception {
      throw exception
    }
  }
}
