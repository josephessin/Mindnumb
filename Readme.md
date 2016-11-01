# Mindnumb

Mindnumb is an implementation of the Mindfudge programming language
designed by Dr. Aaron Block, Ph.D., which is an open specification
designed for students learning compiler design. Mindfudge is heavily
influenced by [a certain other programming language](http://www.muppetlabs.com/~breadbox/bf/).

Mindnumb slightly extends the capabilities of vanilla Mindfudge by
allowing for operators in expressions.

* Mindfudge programs should have access to 30,000 integers in memory. 
  The size of the integers is not specified, and will vary by compiler.
  
* Mindfudge uses ANSI-encoded text files (character values from 0-255).
  Unicode values are not permitted.
  
* Internally, Mindnumb works by keeping track of a pointer that
  references one of the 30,000 integers in memory. This pointer can
  range in value from 0 to 29,999. Various commands modify the value
  of this pointer and the value inside the memory location to which
  it points.


## Credits
* Language specification created by 
  [Dr. Aaron Block, Ph.D.](http://www.aaronblock.com)

* This document was written by [Joseph Essin](https://github.com/josephessin).
  
* [An Easy Explanation of First and Follow Sets](http://www.jambe.co.nz/UNI/FirstAndFollowSets.html)

* [Extended Backus-Naur Form (EBNF)](http://matt.might.net/articles/grammars-bnf-ebnf/)


## Mindnumb Reference

* `left` decrements the pointer by one, if it is greater than zero.

* `left(expression)` decrements the pointer by the specified amount.
  If the pointer value is less than zero, Mindnumb makes it equal
  to zero.
  
  *Unique to Mindnumb*

* `right` increments the pointer by one if it is below 29,999.

* `right(expression)` increments the pointer by the specified amount.
  If the pointer value exceeds 29,999, Mindnumb makes it equal
  to 29,999.
  
  *Unique to Mindnumb*
  
* `add` increments the value of the current memory location specified
  by the pointer.
  Overflow behavior is undefined.
  
* `add(expression)` increments the value of the current memory location
  specified by the pointer by the specified amount.
  Overflow behavior is undefined.

  *Unique to Mindnumb*
  
* `sub` decrements the value of the current memory location specified
  by the pointer.
  Underflow behavior is undefined.
  
* `sub(expression)` decrements the value of the current memory location
  specified by the pointer by the specified amount.
  Underflow behavior is undefined.
    
  *Unique to Mindnumb*
  
* `printA` prints the ASCII value of the current memory location
  specified by the pointer.
  
* `printI` prints the integer value of the current memory location
  specified by the pointer.
  
* `inputA` sets the value of the current memory location specified by
  the pointer to the value of a single ASCII character received from
  the user via command-line input.

* `inputI` sets the value of the current memory location specified by
  the pointer to the value of an integer received from the user via
  command-line input.
  
* `set(expression)` sets the value of the current memory location
  specified by the pointer to be the specified value or expression.
  
* `indexValue` is a built-in variable representing the integer value
  of the current memory location.
  
* `#` denotes a comment. Anything following a hashtag to a new-line
  character is considered a comment.
  
* `make(name, size)` creates an array with the specified name and
  size. All arrays in Mindfudge exist in the global scope.
  Where arrays are carved out in memory is not explicitly defined
  and will vary by compiler.
  
  *Mindnumb chooses to create arrays consecutively in memory whose
  first element is located at the current `indexValue` and whose
  final element is located at `indexValue + (size - 1)`*
  
* `remove(name)` detaches the specified identifier, if it exists,
  from the range of memory it refers to. No other details are
  provided.
  
  *Mindnumb chooses to zero out the memory locations referred
  to by the specified array. If the specified identifier is invalid
  or already allocated, Mindnumb will throw a runtime error.*
  
* `jump(expression)` changes the value of the pointer to the
  specified address value.
  
  *Instead of simply accepting an array name and an optional offset,
  as in vanilla Mindfudge, Mindnumb allows for any valid computed
  expression while still maintaining backwards compatibility.*
  
* `die` immediately halts program execution.

  *Unique to Mindnumb*

* `eq(a, b)` is a built-in function for use in expressions that
  compares two integer expressions. If `a` equals `b`, it
  returns 1, otherwise it returns 0.

* `not(a)` is a built-in function for use in expressions that
  negates the given value. If a is non-zero, not(a) returns 0,
  if it is zero, it returns 1.

* `or(a, b)` is a built-in function for use in expressions that
  returns 1 if either a or b is nonzero, otherwise it returns 0.
  
* `gt(a, b)` is a built-in function for use in expressions that
  compares two integer expressions. If `a > b`, it
  returns 1, otherwise it returns 0.  

* `ge(a, b)` is a built-in function for use in expressions that
  compares two integer expressions. If `a >= b`, it
  returns 1, otherwise it returns 0.
  
* `lt(a, b)` is a built-in function for use in expressions that
  compares two integer expressions. If `a < b`, it
  returns 1, otherwise it returns 0.
  
  *Unique to Mindnumb*
  
* `le(a, b)` is a built-in function for use in expressions that
  compares two integer expressions. If `a <= b`, it
  returns 1, otherwise it returns 0.
  
  *Unique to Mindnumb*
  
* `get(location)` is a built-in function for use in expressions
  that returns the value of the specified memory location.
  `location` can be any valid integer expression.

## Grammar

The grammar is described in 
[Extended Backus-Naur Form (EBNF)](http://matt.might.net/articles/grammars-bnf-ebnf/)
to  the best of the author's ability.

The symbol `::=` is used to mean "produces," as in the following 
grammar example: <code>&lt;x&gt; &rarr; &lt;y&gt;</code>

The following operators are used to describe the grammar:

| Syntax  | Meaning                                               |
| ------: | ----------------------------------------------------- |
| 'c'     | ASCII character literal(s) or escape character(s)     | 
| A?      | Item A is optional (can go to epsilon).               |
| A+      | One or more repetitions of item A                     |
| A*      | Zero or more repetitions of item A                    |
| A B     | Item A followed by item B                             |
| A \| B  | Item A or item B                                      |
| A & B   | Item A or item B, in any order                        | 
| 'a'-'z' | Range of valid characters (inclusive).                |
| !       | Epsilon (null production)                             |

Whitespace within the grammar rules is only provided for readability. 
Where spaces are required in the language, they will be marked as
literals, such as `' '`.

### Lexical Analysis

The grammar specification assumes that the tokenizer/scanner has
already produced a sequential list of tokens in order of their
appearance.

Mindnumb chooses to ignore duplicate whitespace, but other
implementations may not be as forgiving.

The scanner creates tokens based upon the following regular
grammar:

    <printable> ::= Any ASCII character >= 0x20 and <= 0xFF
    <newline> ::= ('\n' | '\r')+
    <whitespace> ::= (' ' | '\t' | <newline>)+
    <del> ::= <whitespace>
    <EOF> ::= '\0'
    <id> ::= ('A'-'Z' | 'a'-'z') ('A'-'Z' | 'a'-'z' | '0'-'9')*
    <integer> ::= '-'? ('0'-'9')+
    <leftBracket> ::= '('
    <rightBracket> ::= ')'
    <comma> ::= ','
    <comment> ::= '#' <printable>* <newline>
    <plus> ::= '+'

The token types produced by the Mindnumb scanner are as follows:

* `EOF` - Denotes the end of file token. May or may not be present
  in the list of tokens given to the parser. If the parser encounters
  the end of the token stream without finding this token, the
  parser infers its presence without warning.
* `id` - Denotes an identifier token (could be a keyword, variable,
  or function call.
* `integer` - Denotes a valid integer token, with an optional
  preceding negative sign.
* `plus` - Denotes a plus sign token, the only accepted Mindfudge
  operator.
* `newline` - Denotes a newline token.
* `leftBracket` - Denotes an opening parenthesis.
* `rightBracket` - Denotes a closing parenthesis.
* `comma` - Denotes a comma.

Mindnumb does not differentiate between keywords at the scanner
level. It also ignores comments as they are scanned, so that the
parser does not have to deliberately exclude them.

Note that integers can be expressed with *any number of initial
zeros* for the sake of padding. This allows the developer to
create nicely formatted Mindfudge code.
            
### Program Flow

Note that `program` **is our start variable**.

    <program> ::= <block> <EOF>
    <block>   ::= <command> <newline> <block>
    		      ::= !
    <command> ::= 'set' '(' <expression> ')'
              ::= 'left' <optionalParameter>
              ::= 'right' <optionalParameter>
              ::= 'add' <optionalParameter>
              ::= 'sub' <optionalParameter>
              ::= 'printA'
              ::= 'printI'
              ::= 'inputA'
              ::= 'inputI'
              ::= 'make' '(' <id> ',' <expression> ')'
              ::= 'remove' '(' <id> ')'
              ::= 'jump' <parenthetical>
              ::= 'while' <parenthetical> <newline> <block> <end>
              ::= 'if' <parenthetical> <newline> <block> <end>
              ::= 'die'
              ::= !
	          
### Expressions

	<returnable> ::= 'get' <parenthetical>
               ::= 'not' <parenthetical>
	             ::= 'eq' '(' <expression> ',' <expression> ')'
               ::= 'or' '(' <expression> ',' <expression> ')'
	             ::= 'gt' '(' <expression> ',' <expression> ')'
	             ::= 'ge' '(' <expression> ',' <expression> ')'
	             ::= 'lt' '(' <expression> ',' <expression> ')'
	             ::= 'le' '(' <expression> ',' <expression> ')'
               
	             
	<value> ::= <returnable>
	        ::= <integer>
	        ::= <id>
	        
	<optionalParameter> ::= <parenthetical>
                      ::= !
	
	<parenthetical> ::= '(' <expression> ')'	
	
	<operation> ::= '+' <expression>
              ::= !

	<expression> ::= <value> <operation>
	             ::= <parenthetical>

## Tables

The following is a list of unexpanded tables describing the prediction rules
for an LL1 Parser. Note that the plus sign `+` denotes the union symbol.

The first tables for terminals have been omitted, as the first of any
terminal is equal to the terminal itself.

### FIRST Table

	FIRST(<program>)
		= FIRST(<block>) + FOLLOW(<block>)
		= {'set', 'left', 'right', 'add', 'sub', 'printA',
		   'printI', 'inputA', 'inputI', 'make', 'remove',
		   'jump', 'while', 'if', 'die', <eof>}
	FIRST(<block>)
		= FIRST(<command>) + FOLLOW(<command>)
		= {'set', 'left', 'right', 'add', 'sub', 'printA',
		   'printI', 'inputA', 'inputI', 'make', 'remove',
		   'jump', 'while', 'if', 'die', <newline>}
	FIRST(<command>) = {'set', 'left', 'right', 'add', 'sub', 'printA',
					           'printI', 'inputA', 'inputI', 'make', 'remove',
                     'jump', 'while', 'if', 'die'}
	FIRST(<returnable>) = {'get', 'eq', 'not', 'or', 'gt', 'ge', 'lt', 'le'}
	FIRST(<value>)
		= FIRST(<returnable>) + {<integer>, <id>}
		= {'get', 'eq', 'not', 'or', 'gt', 'ge', 'lt', 'le',
		  <integer>, <id>}
	FIRST(<optionalParameter>)
		= FIRST(<parenthetical>)
		= {'('}
	FIRST(<parenthetical>) = {'('}
	FIRST(<operation>) = {'+'}
	FIRST(<expression>)
		= FIRST(<value>) + FIRST(<parenthetical>)
		= {'get', 'eq', 'not', 'or', 'gt', 'ge', 'lt', 'le', <integer>,
		   <id>, '('}

### FOLLOW Table

	FOLLOW(<block>) = {<eof>, 'end'}
	FOLLOW(<command>) = {<newline>}
	FOLLOW(<optionalParameter>)
		= FOLLOW(<command>)
		= {<newline>}
	FOLLOW(<expression>) = {',', ')'}
	FOLLOW(<operation>)
		= FOLLOW(<expression>)
		= {',', ')'}

### PREDICT Table

The parser begins with an initial application of the start variable, `<program>`.

	PREDICT(<program> ::= <block> <EOF>)
		= FIRST(<block>) + FOLLOW(<block>)
		= {'set', 'left', 'right', 'add', 'sub', 'printA',
           'printI', 'inputA', 'inputI', 'make', 'remove',
           'jump', 'while', 'if', 'die', 'end', <newline>, <eof>}
	PREDICT(<block> ::= <command> <newline> <block>)
		= FIRST(<command>) + FOLLOW(<command>)
		= {'set', 'left', 'right', 'add', 'sub', 'printA',
           'printI', 'inputA', 'inputI', 'make', 'remove',
           'jump', 'while', 'if', 'die' <newline>}
	PREDICT(<block> ::= !}
		= FOLLOW(<block>)
		= {<eof>, 'end'}
	PREDICT(<command> ::= 'set' '(' <expression> ')') = {'set'}
	PREDICT(<command> ::= 'left' <optionalParameter>) = {'left'}
	PREDICT(<command> ::= 'right' <optionalParameter>) = {'right'}
	PREDICT(<command> ::= 'add' <optionalParameter>) = {'add'}
	PREDICT(<command> ::= 'sub' <optionalParameter>) = {'sub'}
	PREDICT(<command> ::= 'printA') = {'printA'}
	PREDICT(<command> ::= 'printI') = {'printI'}
	PREDICT(<command> ::= 'inputA') = {'inputA'}
	PREDICT(<command> ::= 'inputI') = {'inputI'}
	PREDICT(<command> ::= 'make' '(' <id> ',' <expression> ')') = {'make'}
	PREDICT(<command> ::= 'remove' '(' <id> ')') = {'remove'}
	PREDICT(<command> ::= 'jump' <parenthetical>) = {'jump'}
	PREDICT(<command> ::= 'while' <parenthetical> <newline> <block> <end>) = {'while'}
	PREDICT(<command> ::= 'if' <parenthetical> <newline> <block> <end>) = {'if'}
	PREDICT(<command> ::= 'die') = {'die'}
	PREDICT(<command> ::= !)
		= FOLLOW(<command>)
		= {<newline>}
	PREDICT(<returnable> ::= 'get' <parenthetical>) = 'get'
  PREDICT(<returnable> ::= 'not' <parenthetical>) = 'not'
	PREDICT(<returnable> ::= 'eq' '(' <expression> ',' <expression> ')') = {'eq'}
  PREDICT(<returnable> ::= 'or' '(' <expression> ',' <expression> ')') = {'or'}
	PREDICT(<returnable> ::= 'gt' '(' <expression> ',' <expression> ')') = {'gt'}
	PREDICT(<returnable> ::= 'ge' '(' <expression> ',' <expression> ')') = {'ge'}
	PREDICT(<returnable> ::= 'lt' '(' <expression> ',' <expression> ')') = {'lt'}
	PREDICT(<returnable> ::= 'le' '(' <expression> ',' <expression> ')') = {'le'}
	PREDICT(<value> ::= <returnable>)
		= FIRST(<returnable>)
		= {'get', 'eq', 'or', 'not', 'gt', 'ge', 'lt', 'le'}
	PREDICT(<value> ::= <integer>) = {<integer>}
	PREDICT(<value> ::= <id>) = {<id>}
	PREDICT(<optionalParameter> ::= <parenthetical>)
		= FIRST(<parenthetical>)
		= {'('}
	PREDICT(<optionalParameter> ::= !)
		= FOLLOW(<optionalParameter>)
		= {<newline>}
	PREDICT(<parenthetical> ::= '(' <expression> ')')
		= FIRST(<parenthetical>)
		= '('
	PREDICT(<operation> ::= '+' <expression>) = {'+'}
	PREDICT(<operation> ::= !)
		= FOLLOW(<operation>)
		= {',', ')'}
	PREDICT(<expression> ::= <value> <operation>)
		= FIRST(<value>)
		= {<integer>, <id>}
	PREDICT(<expression> :: = <parenthetical>)
		= FIRST(<parenthetical>)
		= {'('}