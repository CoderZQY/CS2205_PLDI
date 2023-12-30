# CS2205_PLDI
> This repo consists of my solutions to project in CS2205 PLDI.

Website: [CS 2205](https://jhc.sjtu.edu.cn/public/courses/CS2205/)

My blogs: [CS2205_PLDI Notes](https://coderzqy.github.io/2023/12/30/CS2205-PLDI/#more)

`while_f_parser` file is for task: Lexical analysis and syntactic analysis of lexical rule text.

To build:

```
$ make all
```

To test:

```
$ ./main your_test_text
```

For example, my test text is `sample.jtl`, content is as follows:

```
0|[1-9][0-9]* {
  var n; 
  n = build_nat(yytext, yyleng);
  return TM_NAT
};

[_A-Za-z][_A-Za-z0-9]* {
  var str; 
  str = new_str(yytext, yyleng);
  return TM_IDENT
};

[ \t\n\r] { 
  return TM_BLANK
};

"var" {
  return TM_VAR
};

"while" {
    return TM_WHILE
};

";" {
    return TM_SEMICOL
};

"-" {
    return TM_MINUS
};

"*" {
    return TM_MUL
}
```

run `./main sample.jtl`, the output is as follows

```
NAT_RE
  DECL(n,SEQ(ASGN(VAR(n),FUNC(build_nat,VAR(yytext),VAR(yyleng))),RETURN(TM_NAT)))

IDENT_RE
  DECL(str,SEQ(ASGN(VAR(str),FUNC(new_str,VAR(yytext),VAR(yyleng))),RETURN(TM_IDENT)))

BLANK_RE
  RETURN(TM_BLANK)

KW("var")
  RETURN(TM_VAR)

KW("while")
  RETURN(TM_WHILE)

Symbol(";")
  RETURN(TM_SEMICOL)

Symbol("-")
  RETURN(TM_MINUS)

Symbol("*")
  RETURN(TM_MUL)
```



`re2nfa2dfa` file is for task: Regular Expression → NFA → DFA.

To build:

```
$ make all
```

To test:

```
$ ./main
...	// type your regular expression
```
