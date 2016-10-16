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
class Node {
  
  /// The node's children.
  /// The left-most node is considered to be the first element, [0].
  var children: [Node] = []
}
