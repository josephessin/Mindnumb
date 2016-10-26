//
//  CodeContainer.swift
//  Mindfudge
//
//  Created by Joseph Essin on 10/24/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

class CodeContainer {
  
  fileprivate(set) var code: String = ""
  
  fileprivate(set) var indentLevel: Int = 0
  
  fileprivate(set) var vars: Int = 0
  
  func pushVar() -> String {
    vars += 1
    return register()
  }
  
  func popVar() {
    if vars > 0 { vars -= 1 }
  }
  
  func register() -> String {
    return "v" + String(vars)
  }
  
  func append(_ code: String, newline: Bool = true) {
    self.code += String(repeating: " ", count: indentLevel * 4) + code
    if newline {
      self.code += "\n"
    }
  }
  
  func indent() {
    indentLevel += 1
  }
  
  func unindent() {
    if indentLevel > 0 { indentLevel -= 1 }
  }
}
