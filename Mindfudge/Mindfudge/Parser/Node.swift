//
//  Node.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// Represents a node in an abstract syntax tree.
/// Do not initialize this class directly, instead use TerminalNode
/// or a node class that implements loadChildren.
class Node: CustomStringConvertible {
  
  /// The variables (registers) used in code generation.
  static var variables: Int = 0
  
  /// The node's children.
  /// The left-most node is considered to be the first element, [0].
  var children: [Node] = []
  
  /// Represents the code for this element.
  func value(code: CodeContainer) -> String {
    return "node value"
  }
  
  var description: String { return "Node" }
  
  /// Returns the number of spaces specified to make code generation that
  /// much easier.
  private func spaces(_ level: Int) -> String {
    return String(repeating: " ", count: level * 4)
  }
}
