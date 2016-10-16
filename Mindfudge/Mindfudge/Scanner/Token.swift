//
//  Token.swift
//  Mindfudge
//
//  Created by Joseph Essin on 9/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// Represents a type of token.
enum Token: CustomStringConvertible {
  /// Identifier
  case id(String)
  /// Integer value
  case integer(String)
  /// Operator
  case op(String)
  /// Comment
  case comment(String)
  /// End of file token
  case eof
  /// Newline
  case newline
  /// Opening parenthesis
  case parenthesisOpen
  /// Closing parenthesis
  case parenthesisClose
  /// Comma
  case comma
  
  var description: String {
    switch self {
    case let .id(string): return "id(" + string + ")"
    case let .integer(int): return "integer(" + String(int) + ")"
    case let .op(string): return "operator(" + string + ")"
    case let .comment(string): return "comment(" + string + ")"
    case .eof: return "eof"
    case .newline: return "newline"
    case .parenthesisOpen: return "parenthesis_open"
    case .parenthesisClose: return "parenthesis_close"
    case .comma: return "comma"
    }
  }
}

