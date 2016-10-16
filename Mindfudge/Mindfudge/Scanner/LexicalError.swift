//
//  LexicalError.swift
//  Mindfudge
//
//  Created by Joseph Essin on 9/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation
  
  /// Failable errors thrown by the scanner.
  enum LexicalError : Error, CustomStringConvertible {
    case endOfFile
    case invalidCharacter(String)
    
    // MARK: CustomStringConvertible
    
    var description: String {
      switch self {
      case .endOfFile:
        return "The end of the file was encountered unexepectedly " +
        "while scanning."
      case let .invalidCharacter(str):
        return "Invalid character found while scanning token: " + str
      }
    }
    
  }
