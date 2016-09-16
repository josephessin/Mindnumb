//
//  String-CStringInit.swift
//  RichTextParser
//
//  Created by Joseph Essin on 9/3/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Foundation

extension CChar {
  
  /// The char, converted to a string.
  var string: String {
    let scalar = UnicodeScalar(UInt8(self))
    return String(scalar)
  }
  
}
