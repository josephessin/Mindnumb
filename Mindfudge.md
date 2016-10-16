# Mindnumb

Mindnumb is an implementation of the Mindfudge programming language
designed by Dr. Aaron Block, Ph.D. which is an open specification
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

* `eq(a, b)` is a built-in function for use in expressions that
  compares two integer expressions. If `a` equals `b`, it
  returns 1, otherwise it returns 0.
  
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
	          ::= 'printA' <optionalParameter>
			  ::= 'printI'
			  ::= 'inputA'
			  ::= 'inputI'
	          ::= 'make' '(' <id> ',' <expression> ')'
	          ::= 'remove' '(' <id> ')'
	          ::= 'jump' <parenthetical>
	          ::= 'while' <parenthetical> <newline> <block> <end>
	          ::= 'if' <parenthetical> <newline> <block> <end>
	          ::= 'end'
	          ::= !
	          
### Expressions

	<returnable> ::= 'get' <parenthetical>
	             ::= 'eq' '(' <expression> ',' <expression> ')'
	             ::= 'gt' '(' <expression> ',' <expression> ')'
	             ::= 'ge' '(' <expression> ',' <expression> ')'
	             ::= 'lt' '(' <expression> ',' <expression> ')'
	             ::= 'le' '(' <expression> ',' <expression> ')'
	             
	<value> ::= <returnable>
	        ::= 'indexValue'
	        ::= <integer>
	        ::= <id>
	        
	<optionalParameter> ::= <parenthetical>
						::= !
	
	<parenthetical> ::= '(' <expression> ')'	
	
	<operation> ::= '+' <expression>
			    ::= !

	<expression> ::= <value> <operation>
	             ::= <parenthetical>
	             ::= !

## Tables

The following is a list of unexpanded tables describing the prediction rules
for an LL1 Parser. Note that the plus sign `+` denotes the union symbol.

The first tables for terminals have been omitted, as the first of any
terminal is equal to the terminal itself.

### FIRST Table

	FIRST(<program>) = FIRST(<block>)
	FIRST(<block>) = FIRST(<command>) + <newline>
	FIRST(<command>) = FIRST(<left>)
					 + FIRST(<right>)
					 + FIRST(<printA>)
					 + FIRST(<printI>)
					 + FIRST(<inputA>)
					 + FIRST(<inputI>)
					 + FIRST(<make>)
					 + FIRST(<remove>)
					 + FIRST(<jump>)
					 + FIRST(<while>)
					 + FIRST(<if>)
					 
	FIRST(<returnable>) = FIRST(<get>)
					    + FIRST(<eq>)
					    + FIRST(<gt>)
					    + FIRST(<ge>)
					    + FIRST(<lt>)
					    + FIRST(<le>)
					    
	FIRST(<value>) = FIRST(<returnable>)
				   + 'indexValue'
				   + <integer>
				   + <id>
				   
	FIRST(<optionalParameter>) = FIRST(<parenthetical>)
				   
	FIRST(<parenthetical>) = '('
	
	FIRST(<operation>) = '+'

	FIRST(<expression>) = FIRST(<value>)
						+ FIRST(<parenthetical>)
					 
	FIRST(<left>) = 'left'
	FIRST(<right>) = 'right'
	
	FIRST(<add>) = 'add'
	FIRST(<sub>) = 'sub'
	
	FIRST(<printA>) = 'printA'
	FIRST(<printI>) = 'printI'
	FIRST(<inputA>) = 'inputA'
	FIRST(<inputI>) = 'inputI'
	
	FIRST(<make>) = 'make'
	FIRST(<remove>) = 'remove'
	FIRST(<jump>) = 'jump'
	
	FIRST(<while>) = 'while'
	FIRST(<if>) = 'if'	
	FIRST(<end>) = 'end'
	
	FIRST(<get>) = 'get'
	FIRST(<eq>) = 'eq'
	FIRST(<gt>) = 'gt'
	FIRST(<ge>) = 'ge'
	FIRST(<lt>) = 'lt'
	FIRST(<le>) = 'le
	
	
### FOLLOW Table

	FOLLOW(<block>) = <EOF>
					+ FIRST(<end>)
	FOLLOW(<command>) = <newline>
	
	FOLLOW(<optionalParameter>) = FOLLOW(<command>)
	FOLLOW(<operation>) = FOLLOW(<expression>)
	FOLLOW(<expression>) = ')' + ','

### PREDICT Table

The parser begins with an initial prediction of the start variable. 

	PREDICT(<program> ::= <block> <EOF>) = FIRST(<block>)
	PREDICT(<block> ::= <command> <newline> <block>) = FIRST(<command>)
													 + FOLLOW(<command>)
	PREDICT(<block> ::= !) = FOLLOW(<block>)
													 
	PREDICT(<command> ::= <left>) = FIRST(<left>)
	PREDICT(<command> ::= <right>) = FIRST(<right>)
	PREDICT(<command> ::= <add>) = FIRST(<add>)
	PREDICT(<command> ::= <sub>) = FIRST(<sub>)
	PREDICT(<command> ::= <printA>) = FIRST(<printA>)
	PREDICT(<command> ::= <printI>) = FIRST(<printI>)
	PREDICT(<command> ::= <inputA>) = FIRST(<inputA>)
	PREDICT(<command> ::= <inputI>) = FIRST(<inputI>)
	PREDICT(<command> ::= <make>) = FIRST(<make>)
	PREDICT(<command> ::= <remove>) = FIRST(<remove>)
	PREDICT(<command> ::= <jump>) = FIRST(<jump>)
	PREDICT(<command> ::= <while>) = FIRST(<while>)
	PREDICT(<command> ::= <if>) = FIRST(<if>)
	PREDICT(<command> ::= !) = <newline>
	
	PREDICT(<returnable> ::= <get>) = FIRST(<get>)
	PREDICT(<returnable> ::= <eq>) = FIRST(<eq>)
	PREDICT(<returnable> ::= <gt>) = FIRST(<gt>)
	PREDICT(<returnable> ::= <ge>) = FIRST(<ge>)
	PREDICT(<returnable> ::= <lt>) = FIRST(<lt>)
	PREDICT(<returnable> ::= <le>) = FIRST(<le>)
	
	PREDICT(<value> ::= <returnable>) = FIRST(<returnable>)
	PREDICT(<value> ::= 'indexValue') = 'indexValue'
	PREDICT(<value> ::= <integer>) = <integer>
	PREDICT(<value> ::= <id>) = <id>
	
	PREDICT(<optionalParameter> ::= <parenthetical>) = FIRST(<parenthetical>)
	PREDICT(<optionalParameter> ::= !) = FOLLOW(<optionalParameter>)

	PREDICT(<parenthetical> ::= '(' + <expression> + ')') = FIRST(<parenthetical>)

	PREDICT(<operation> ::= '+' <expression>) = '+'
	PREDICT(<operation> ::= !) = FOLLOW(<operation>)
	
	PREDICT(<expression> ::= <value> <operation>) = FIRST(<value>)
	PREDICT(<expression> ::= <parenthetical>) = FIRST(<parenthetical>)
	PREDICT(<expression> ::= !) = FOLLOW(<expression>)
	
	PREDICT(<left> ::= 'left' <parenthetical>?) = 'left'
	PREDICT(<right> ::= 'right' <parenthetical>?) = 'right'
	
	PREDICT(<add> ::= 'add' <parenthetical>?) = 'add'
	PREDICT(<sub> ::= 'sub' <parenthetical>?) = 'sub'
	
	PREDICT(<printA> ::= 'printA' <parenthetical>?) = 'printA'
	PREDICT(<printI> ::= 'printI') = 'printI'
	PREDICT(<inputA> ::= 'inputA') = 'inputA'
	PREDICT(<inputI> ::= 'inputI') = 'inputI'
	
	PREDICT(<make> ::= 'make' '(' <id> ',' <integer> ')') = 'make'
	PREDICT(<remove> ::= 'array' '(' <id> ')') = 'remove'
	PREDICT(<jump> ::= <parenthetical>) = 'jump'
	
	PREDICT(<while> ::= 'while' <parenthetical> <newline> <block> <end>) = 'while'
	PREDICT(<if> ::= 'if' <parenthetical> <newline> <block> <end>) = 'if'
	PREDICT(<end> ::= 'end')

	PREDICT(<get> ::= 'get' <parenthetical>)
	PREDICT(<eq> ::= 'eq' '(' <expression> ',' <expression> ')') = 'eq'
	PREDICT(<gt> ::= 'gt' '(' <expression> ',' <expression> ')') = 'gt'
	PREDICT(<ge> ::= 'ge' '(' <expression> ',' <expression> ')') = 'ge'
	PREDICT(<lt> ::= 'lt' '(' <expression> ',' <expression> ')') = 'lt'
	PREDICT(<le> ::= 'le' '(' <expression> ',' <expression> ')') = 'le'

**Generate:** 

FIRST for every variable (and terminal, but it's the terminal itself)
FOLLOW for every variable
PREDICT for every RULE

## Usage Notes
Meaning of operations:

| Function | Returns                                         |
| -------- | ----------------------------------------------- |
| get(x)   | Returns the value at the specified location     |
| eq(a,b)  | Returns true if a is equal to b                 |
| gt(a,b)  | Returns true if a is greater than b             |
| ge(a,b)  | Returns true if a is greater than or equal to b |
| lt(a,b)  | Returns true if a is less than b                |
| le(a,b)  | Returns true if a is less than or equal to b    |

Note: `get(x)` returns the starting index of an array if given
an identifier, and returns the value of the location in 
memory if given an integer.

Mindnumb converts the original comparison commands to be
built in functions that return zero or one, allowing them to be
used in expressions. It also adds support for *less-than* (`lt()`)
and *less-than-or-equal-to* (`le()`), which was not possible in the original
Mindfudge specification.

Example of using the `get` to dereference memory locations:

	# We begin at slot 0 in memory.
	# All memory locations are guaranteed to be 0 until modified.
	#
	right 5        # Go to slot 5 in memory
	set -1         # Set the value of slot 5 to be -1
	left 5         # Go back to slot 0.
	right 10       # Go to slot 10 in memory
	set 5          # Set the value of slot 10 to be 5
	make array1 10  # Create an array from slot 10 to 19 (inclusive)
	left 10        # Go back to slot 0 in memory
    set get(get(get(array1)))
    # Note:
    # get(array1) = 10
    #   The address (starting location) of array1.
    # get(get(array1)) = 5
    #   The value of the first item in array1.
    # get(get(get(array1))) = -1
    #   The value at the location in memory referenced by
    #   the value of the first item in array1.