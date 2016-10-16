# Mindfudge Parser

Guidelines and Questions:

* Make one tree PER line of code that isn't a block.
* Memory management must be defined for the language to be multi-platform?
* Validating statement labels??
* RuleNode class with an arbitrary number of children
* Subclass RuleNode for each grammar rule and fill in the terminals.
  The parser picks up at the left-most child that doesn't have a terminal in it.
* Keep a stack that holds every node you've looked at and what child you were
  looking at. When you reach the end of a node, pop it off the stack and go back
  to the previous node, and then continue working toward the children on the right.

	Subclass structure of grammar tree:
	
    Element (a single node) -> (Variable, Terminal)
    Variable -> All non-terminals
    Terminal -> Holds a predefined terminal


## Memory Management


Tree type?

How to store rules in memory?

