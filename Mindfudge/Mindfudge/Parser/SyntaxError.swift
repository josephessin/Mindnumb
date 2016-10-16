//
//  SyntaxError.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// Represents an error encountered while creating the abstract syntax tree.
enum SyntaxError: Error {
  /// An invalid token was encountered.
  case invalidToken(found: Token)
}
