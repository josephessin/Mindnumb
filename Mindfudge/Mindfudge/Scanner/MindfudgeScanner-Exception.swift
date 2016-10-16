//
//  MindfudgeScanner-Error.swift
//  Mindfudge
//
//  Created by Joseph Essin on 9/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

extension MindfudgeScanner {
  
  /// Failable errors thrown by the scanner.
  enum Exception : Error, CustomStringConvertible {
    case endOfFile
    case invalidInteger
    case invalidCharacter
    
    // MARK: CustomStringConvertible
    
    var description: String {
      switch self {
      case .endOfFile:
        return "The end of the file was encountered unexepectedly " +
        "while scanning."
      case .invalidInteger:
        return "Couldn't convert the token string to an integer value."
      case .invalidCharacter:
        return "Invalid character found while scanning token."
      }
    }
    
  }
  
}
