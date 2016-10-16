//
//  MindfudgeParser.swift
//  Mindfudge
//
//  Created by Joseph Essin on 9/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class MindfudgeParser {
  
  /// An array of tokens.
  private(set) var tokens: [Token] = []
  
  /// Creates a new parser for the specified Mindfudge code.
  init(code: String) throws {
    let scanner = MindfudgeScanner(withString: code)
    do {
      // Construct an array of tokens for grammatical analysis
      while let token = try scanner.nextToken() {
        switch token {
        case .comment:
          break
        default:
          tokens += [token]
        }
      }
    } catch let exception {
      // Throw any problems up the call stack.
      throw exception
    }
  }
}
