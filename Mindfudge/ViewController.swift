//
//  ViewController.swift
//  Mindfudge
//
//  Created by Joseph Essin on 9/15/16.
//  Copyright © 2016 Joseph Essin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  override func viewDidAppear() {
    super.viewDidAppear()
    
    // Load our Mindfudge Code:
    let path = Bundle.main.path(forResource: "code", ofType: "txt")!
    let string = try! String(contentsOfFile: path)
    
    let parser = MindfudgeParser(code: string)
    do {
      // Attempt to parse the mindfudge code.
      try parser.parse()
      Swift.print("Tokens: ")
      print(parser.tokens.description)
      parser.ast?.print()
      print("SUCCESSFUL PARSE")
      
      if let code = parser.ast?.code() {
        print(code)
        print("SUCCESSFUL COMPILATION")
      }
    } catch let exception {
      Swift.print("Error: " + String(describing: exception))
    }
  }
}

