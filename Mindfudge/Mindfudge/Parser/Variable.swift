//
//  Variable.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// Implemented by CFG rule nodes so that they can apply the right production
/// rule when given the current token.
protocol Variable {
  
  /// Load the appropriate child nodes based upon the predict rules, given
  /// the current token.
  func loadChildren(fromLookAhead token: Token) throws
}
