//
//  ASCII.swift
//  RichTextParser
//
//  Created by Joseph Essin on 9/7/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

/// Stores ASCII codes, for your convenience.
struct ASCII {
  /// ASCII code for {
  static let curlyBraceOpen: CChar = 123
  /// ASCII code for }
  static let curlyBraceClosed: CChar = 125
  /// ASCII code for \
  static let backslash: CChar = 92
  /// ASCII code for *
  static let asterisk: CChar = 42
  /// ASCII code for space
  static let space: CChar = 32
  /// ASCII code for line feed
  static let lf: CChar = 10
  /// ASCII code for carriage return
  static let cr: CChar = 13
  /// ASCII code for tab
  static let tab: CChar = 9
  /// ASCII code for '
  static let apostrophe: CChar = 39
  /// ASCII code for a
  static let A: CChar = 65
  /// ASCII code for A
  static let a: CChar = 97
  /// ASCII code for Z
  static let Z: CChar = 90
  /// ASCII code for z
  static let z: CChar = 122
  /// ASCII code for 0
  static let zero: CChar = 48
  /// ASCII code for 9
  static let nine: CChar = 57
  /// ASCII code for ;
  static let semicolon: CChar = 59
  /// ASCII code for -
  static let minusSign: CChar = 45
  /// ASCII code for -, same as minuSign.
  static let hyphen: CChar = 45
  /// ASCII code for f
  static let f: CChar = 102
  /// ASCII code for F
  static let F: CChar = 70
  /// ASCII code for |
  static let pipe: CChar = 124
  /// ASCII code for ~
  static let tilde: CChar = 126
  /// ASCII code for _
  static let underscore: CChar = 95
}