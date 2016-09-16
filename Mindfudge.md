# Mindfudge

Mindfudge is a programming language created by Dr. Aaron Block,
Ph.D. and is an open specification designed for students learning
compiler design.

Mindfudge programs should have access to 30,000 integers in memory.

The size of the integers was not specified.

Mindfudge uses ANSI-encoded text files (character values from
0-255). Unicode values are not permitted.

## Credits
Language specification created by 
[Dr. Aaron Block, Ph.D.](http://www.aaronblock.com)

This context-free-grammar specification for an LL(1) parser
was created by [Joseph Essin](https://github.com/josephessin).

## Language Specification


## Grammar Syntax

The grammar is described in 
[Extended Backus-Naur Form (EBNF)](http://matt.might.net/articles/grammars-bnf-ebnf/)
to  the best of the author's ability.

The symbol `::=` is used to mean "produces," as in the following 
grammar example: <code>&lt;x&gt; &rarr; &lt;y&gt;</code>

The following operators are used to describe the grammar:

| Syntax  | Meaning                                               |
| ------- | ----------------------------------------------------- |
| 'c'     | ASCII character literal(s) or escape character(s)     | 
| A?      | Item A is optional                                    |
| A+      | One or more repetitions of item A                     |
| A*      | Zero or more repetitions of item A                    |
| A B     | Item A followed by item B                             |
| A \| B  | Item A or item B                                      |
| A & B   | Item A or item B, in any order                        | 
| 'a'-'z' | Character literal range between the specified values. |

## Grammar

The following tokens represent regular expressions that can be
used to tokenize a given input file.

Note that integers can be expressed with *any number of initial
zeros* for the sake of padding.

    <printable> ::= Any ASCII character >= 0x20 and <= 0xFF
    <newline> ::= '\n' | '\r' | '\f'
    <whitespace> ::= (' ' | <newline>)+
    <id> ::= ('A'-'Z' | 'a'-'z')+ ('A'-'Z' | 'a'-'z' | '0'-'9')*
    <integer> ::= '-'? ('0'-'9')+
    <comment> ::= '#' <printable>* <newline>
    <plus> ::= '+'
    <literal> ::= (<integer> | <indexValue>)
    <expression> ::= <evaluable> | <literal>
    
    <move> ::= 'left' | 'right'
    <modify> ::= 'add' | 'sub'
    <print> ::= 'printA' | 'printI'
    <input> ::= 'inputA' | 'inputI'
    <indexValue> ::= 'indexValue'
    <set> ::= 'set' <expression>
    <while> ::= 'while' <whitespace> <expression> <whitespace> 'id'
    
    <evaluable> ::= <eq> | <gt> | <ge> | <get>  
    
    <eq> ::= 'eq' <whitespace> <literal> <whitespace> <literal>
    <gt> ::= 'gt' <whitespace> <literal> <whitespace> <literal>
    <ge> ::= 'ge' <whitespace> <literal> <whitespace> <literal>
    <get> ::= 'get' <whitespace> <expression>
