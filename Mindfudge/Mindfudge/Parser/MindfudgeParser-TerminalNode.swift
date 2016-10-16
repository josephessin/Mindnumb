//
//  MindfudgeParser-TerminalNode.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/15/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

extension MindfudgeParser {
  
  /// Represents a terminal node.
  class TerminalNode: MindfudgeNode {
    /// The token representing the terminal node's value.
    fileprivate(set) var token: MindfudgeScanner.Token
    
    /// Creates a new terminal node with the specified token value.
    init(token: MindfudgeScanner.Token) {
      self.token = token
    }
  }
  
}
