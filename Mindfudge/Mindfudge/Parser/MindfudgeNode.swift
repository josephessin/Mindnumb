//
//  MindfudgeNode.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/15/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// Represents a node in an abstract syntax tree.
protocol MindfudgeNode {
  /// The node's children (for the tree it is presumably in).
  var children: [Node] { get }
}
