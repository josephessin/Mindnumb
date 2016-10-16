//
//  MindfudgeParser.swift
//  Mindfudge
//
//  Created by Joseph Essin on 9/16/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class MindfudgeParser {
  
  private let code: String
  let scanner: MindfudgeScanner
  
  /// An array of tokens.
  fileprivate(set) var tokens: [Token] = []
  
  fileprivate(set) var ast: AbstractSyntaxTree!
  
  /// Creates a new parser for the specified Mindfudge code.
  init(code: String) {
    self.code = code
    self.scanner = MindfudgeScanner(withString: code)
  }
  
  func parse() throws {
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
    
    print("Tokens: ")
    print(tokens.description)
    
    self.ast = try AbstractSyntaxTree(tokens: tokens)
    try ast?.parse()
  }
}
