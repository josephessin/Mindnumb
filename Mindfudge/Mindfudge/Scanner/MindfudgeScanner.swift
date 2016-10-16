//
//  MindfudgeScanner.swift
//  Mindfudge
//
//  Created by Joseph Essin on 9/15/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// An object for constructing a logical sequence of tokens from a
/// raw string containing Mindfudge code.
class MindfudgeScanner {
  
  /// A pointer to the c-characters for the string we are scanning.
  let characters: [CChar]
  
  /// The current character index.
  private(set) var position: Int = 0
  
  /// Creates a new Mindfudge scanner with the specified code string.
  init(withString string: String) {
    characters = string.cString(using: String.Encoding.ascii)!
  }
  
  /// Returns the next token.
  func nextToken() throws -> Token? {
    var char: CChar? = get()
    if char == nil { return nil }
    
    while isWhitespace(char!) {
      /// Gobble up any leading whitespace.
      char = get()
      if char == nil { return nil }
    }
    
    if isLineFeed(char!) {
      // Gobble up any following line feeds:
      while isLineFeed(char!) {
        char = get()
        if char == nil { break }
      }
      if let char = char, !isWhitespace(char) { unget() }
      return Token(type: .newline)
    } else if char! == ASCII.parenthesisOpen {
      // Opening parenthesis
      return Token(type: .parenthesisOpen)
    } else if char! == ASCII.parenthesisClose {
      // Closing parenthesis
      return Token(type: .parenthesisClose)
    } else if char! == ASCII.comma {
      // Comma
      return Token(type: .comma)
    } else if isAlpha(char!) {
      // Found an identifier
      var buffer: String = ""
      while isAlphanumeric(char!) {
        buffer += char!.string
        char = get()
        if char == nil { break }
      }
      if let char = char, !isWhitespace(char) { unget() }
      return Token(type: .id, value: buffer)
    } else if isDigit(char!) || char! == ASCII.minusSign {
      // Found an integer
      var buffer: String = ""
      if char! == ASCII.minusSign {
        // First character is a negative sign, go ahead and
        // put it in our string...
        buffer += char!.string
        char = get()
        if char == nil { throw Exception.endOfFile }
      }
      if !isDigit(char!) {
        // Found a non digit when we expected a digit.
        throw Exception.invalidCharacter
      }
      while isDigit(char!) {
        buffer += char!.string
        char = get()
        if char == nil { break }
      }
      if !isWhitespace(char!) { unget() }
      if let integer = Int(buffer) {
        return Token(type: .integer, value: integer)
      } else {
        throw Exception.invalidInteger
      }
    } else if char! == ASCII.plusSign {
      // Found the plus operator
      return Token(type: .plus, value: char!.string)
    } else if char! == ASCII.hashtag {
      // Found a comment:
      var buffer: String = ""
      while !isLineFeed(char!) {
        // Gobble up the rest of the line.
        buffer += char!.string
        char = get()
        if char == nil { break }
      }
      return Token(type: .comment, value: buffer)
    } else {
      if char! != 0 {
        // Invalid character found!
        NSLog("Invalid character at index: " + String(position))
        NSLog("Found: " + char!.string)
        throw Exception.invalidCharacter
      } else {
        // Create an end of file token.
        return Token(type: .eof)
      }
    }
  }
  
  /// Acquires the next character in the RTF stream, or nil if the
  /// end of the file has been reached.
  private func get() -> CChar? {
    if position < characters.count {
      let nextChar = characters[position]
      position += 1
      return nextChar
    }
    return nil
  }
  
  /// Moves the character pointer back by one, if possible.
  private func unget() {
    if position > 0 {
      position -= 1
    }
  }
  
  /// Returns true if the specified character is considered whitespace.
  func isWhitespace(_ char: CChar) -> Bool {
    if char == ASCII.space || char == ASCII.tab {
      return true
    }
    return false
  }
  
  /// Returns true if the specified character is considered a line feed.
  func isLineFeed(_ char: CChar) -> Bool {
    if char == ASCII.lf || char == ASCII.cr { return true }
    return false
  }
  
  /// Returns true if the specified character is an operator.
  /// Currently, mindfudge recognizes `-` for negative integers, and `+` for
  /// the get command.
  func isOperator(_ char: CChar) -> Bool {
    if char == ASCII.plusSign || char == ASCII.minusSign { return true }
    return false
  }
  
  /// Returns true if the specified character ranges from 0...9 (inclusive)
  func isDigit(_ char: CChar) -> Bool {
    if char >= ASCII.zero && char <= ASCII.nine { return true }
    return false
  }
  
  /// Returns true if the specified character is alphanumeric.
  func isAlphanumeric(_ char: CChar) -> Bool {
    if isAlpha(char) || isDigit(char) { return true }
    return false
  }
  
  /// Returns true if the specified character ranges from a...z or
  /// A...Z (inclusive)
  func isAlpha(_ char: CChar) -> Bool {
    if (char >= ASCII.a && char <= ASCII.z)
      || (char >= ASCII.A && char <= ASCII.Z) { return true }
    return false
  }

}
