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
    
    do {
      
      // Attempt to parse the mindfudge code.
      let parser = try MindfudgeParser(code: string)
      NSLog("Tokens: ")
      for token in parser.tokens {
        if token.description != "" {
          print(token.type.description + " = '" + token.description + "'")
        } else {
          print(token.type.description)
        }
      }
      
    } catch let exception {
      NSLog("Error: " + String(describing: exception))
    }
  }
}

