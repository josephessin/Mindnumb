//
//  MindfudgeScanner-Token.swift
//  Mindfudge
//
//  Created by Joseph Essin on 9/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

extension MindfudgeScanner {
  
  /// A token that has been scanned by a MindfudgeScanner.
  struct Token: CustomStringConvertible {
    
    /// The value of the token.
    let description: String
    
    // The integer value of the token, if applicable.
    let value: Int?
    
    /// The type of the token.
    let type: TokenType
    
    /// Creates a new token with the specified type and a blank string value.
    init(type: TokenType) {
      description = ""
      self.value = nil
      self.type = type
    }
    
    /// Creates a new token with the specified string value.
    init(type: TokenType, value: String) {
      description = value
      self.value = nil
      self.type = type
    }
    
    /// Creates a new token with the specified integer value.
    init(type: TokenType, value: Int) {
      description = String(value)
      self.value = value
      self.type = type
    }
    
  }
  
}
