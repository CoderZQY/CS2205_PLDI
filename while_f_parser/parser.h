/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_H_INCLUDED
# define YY_YY_PARSER_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    TM_NAT = 258,                  /* TM_NAT  */
    TM_IDENT = 259,                /* TM_IDENT  */
    TM_KEYWORD = 260,              /* TM_KEYWORD  */
    TM_SYMBOL = 261,               /* TM_SYMBOL  */
    TM_LEFT_BRACE = 262,           /* TM_LEFT_BRACE  */
    TM_RIGHT_BRACE = 263,          /* TM_RIGHT_BRACE  */
    TM_LEFT_PAREN = 264,           /* TM_LEFT_PAREN  */
    TM_RIGHT_PAREN = 265,          /* TM_RIGHT_PAREN  */
    TM_SEMICOL = 266,              /* TM_SEMICOL  */
    TM_VAR = 267,                  /* TM_VAR  */
    TM_IF = 268,                   /* TM_IF  */
    TM_THEN = 269,                 /* TM_THEN  */
    TM_ELSE = 270,                 /* TM_ELSE  */
    TM_WHILE = 271,                /* TM_WHILE  */
    TM_DO = 272,                   /* TM_DO  */
    TM_ASGNOP = 273,               /* TM_ASGNOP  */
    TM_OR = 274,                   /* TM_OR  */
    TM_AND = 275,                  /* TM_AND  */
    TM_NOT = 276,                  /* TM_NOT  */
    TM_LT = 277,                   /* TM_LT  */
    TM_LE = 278,                   /* TM_LE  */
    TM_GT = 279,                   /* TM_GT  */
    TM_GE = 280,                   /* TM_GE  */
    TM_EQ = 281,                   /* TM_EQ  */
    TM_NE = 282,                   /* TM_NE  */
    TM_PLUS = 283,                 /* TM_PLUS  */
    TM_MINUS = 284,                /* TM_MINUS  */
    TM_MUL = 285,                  /* TM_MUL  */
    TM_DIV = 286,                  /* TM_DIV  */
    TM_MOD = 287,                  /* TM_MOD  */
    TM_UMINUS = 288,               /* TM_UMINUS  */
    TM_DEREF = 289,                /* TM_DEREF  */
    TM_func = 290,                 /* TM_func  */
    TM_proc = 291,                 /* TM_proc  */
    TM_continue = 292,             /* TM_continue  */
    TM_break = 293,                /* TM_break  */
    TM_return = 294,               /* TM_return  */
    TM_comma = 295,                /* TM_comma  */
    TM_and = 296,                  /* TM_and  */
    TM_for = 297,                  /* TM_for  */
    TM_NAT_RE = 298,               /* TM_NAT_RE  */
    TM_IDENT_RE = 299,             /* TM_IDENT_RE  */
    TM_BLANK_RE = 300              /* TM_BLANK_RE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 10 "lang.y"

unsigned int n;
char * i;
struct expr * e;
struct cmd * c;
struct glob_item * g;
struct glob_item_list * f;
struct expr_list * h;
struct var_list *k;
void * none;

#line 121 "parser.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_H_INCLUDED  */
