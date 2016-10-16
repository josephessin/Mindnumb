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
  
  /// Creates a new terminal node with the specified token value.
  init(token: Token) {
    self.token = token
  }
}
