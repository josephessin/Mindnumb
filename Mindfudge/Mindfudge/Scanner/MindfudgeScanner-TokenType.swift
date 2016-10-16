//
//  MindfudgeScanner-TokenType.swift
//  Mindfudge
//
//  Created by Joseph Essin on 9/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

extension MindfudgeScanner {
  
  /// Represents a type of token.
  enum TokenType: CustomStringConvertible {
    /// Identifier
    case id
    /// Integer value
    case integer
    /// Plus sign operator.
    case plus
    /// Comment
    case comment
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
      case .id: return "id"
      case .integer: return "integer"
      case .plus: return "plus"
      case .comment: return "comment"
      case .eof: return "eof"
      case .newline: return "newline"
      case .parenthesisOpen: return "parenthesis_open"
      case .parenthesisClose: return "parenthesis_close"
      case .comma: return "comma"
      }
    }
  }
  
}
