%{
	#include <stdio.h>
	#include "lang.h"
	#include "lexer.h"
	void yyerror(char *);
	int yylex(void);
  struct glob_item_list * root;
%}

%union {
unsigned int n;
char * i;
struct expr * e;
struct cmd * c;
struct glob_item * g;
struct glob_item_list * f;
struct expr_list * h;
struct var_list *k;
void * none;
}

// Terminals
%token <n> TM_NAT
%token <i> TM_IDENT TM_KEYWORD TM_SYMBOL
%token <none> TM_LEFT_BRACE TM_RIGHT_BRACE
%token <none> TM_LEFT_PAREN TM_RIGHT_PAREN
%token <none> TM_SEMICOL 

%token <none> TM_VAR TM_IF TM_THEN TM_ELSE TM_WHILE TM_DO 
%token <none> TM_ASGNOP
%token <none> TM_OR
%token <none> TM_AND
%token <none> TM_NOT
%token <none> TM_LT TM_LE TM_GT TM_GE TM_EQ TM_NE
%token <none> TM_PLUS TM_MINUS
%token <none> TM_MUL TM_DIV TM_MOD
%token <none> TM_UMINUS TM_DEREF 
%token <none> TM_func TM_proc TM_continue TM_break TM_return TM_comma TM_and TM_for 
%token <none> TM_NAT_RE TM_IDENT_RE TM_BLANK_RE

%type <g> NT_gi
%type <f> NT_gil
%type <c> NT_CMD
%type <h> NT_el
%type <k> NT_vl
%type <e> NT_EXPR

%nonassoc TM_ASGNOP
%left TM_OR
%left TM_AND
%left TM_LT TM_LE TM_GT TM_GE TM_EQ TM_NE
%left TM_PLUS TM_MINUS
%left TM_MUL TM_DIV TM_MOD
%right TM_UMINUS TM_DEREF TM_and
%left TM_NOT
%left TM_LEFT_PAREN TM_RIGHT_PAREN
%right TM_SEMICOL

%%

NT_gil :
  NT_gi TM_SEMICOL NT_gil
  {
    $$ = (TGCons($1,$3));
    root = $$;
  }
| NT_gi
  { 
    $$ = (TGCons($1,TGNil()));
    root = $$;
  }

;

NT_el :
  NT_EXPR TM_comma NT_el
  {
    $$ = (TECons($1,$3));
  }
|  NT_EXPR
  {
    $$ = (TECons($1,TENil()));
  }

;

NT_vl :
  TM_IDENT TM_comma NT_vl
  {
    $$ = (TVCons($1,$3));
  }
|  TM_IDENT
  {
    $$ = (TVCons($1,TVNil()));
  }
;


NT_CMD:
  TM_VAR TM_IDENT TM_SEMICOL NT_CMD
  {
    $$ = (TDecl($2,$4));
  }  
| NT_EXPR TM_ASGNOP NT_EXPR
  {
    $$ = (TAsgn($1,$3));
  }
| NT_CMD TM_SEMICOL NT_CMD
  {
    $$ = (TSeq($1,$3));
  }
| TM_IF TM_LEFT_PAREN NT_EXPR TM_RIGHT_PAREN TM_THEN TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE TM_ELSE TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TIf($3,$7,$11));
  }
| TM_WHILE TM_LEFT_PAREN NT_EXPR TM_RIGHT_PAREN TM_DO TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TWhile($3,$7));
  }
| TM_for TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE TM_LEFT_PAREN NT_EXPR TM_RIGHT_PAREN TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TFor($3,$6,$9,$12));
  }
| TM_DO TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE TM_WHILE TM_LEFT_PAREN NT_EXPR TM_RIGHT_PAREN
  {
    $$ = (TDoWhile($3,$7));
  }
| TM_IDENT TM_LEFT_PAREN NT_el TM_RIGHT_PAREN
  {
    $$ = (TProc($1,$3));
  }
| TM_IDENT TM_LEFT_PAREN TM_RIGHT_PAREN
  {
    $$ = (TProc($1,TENil()));
  }  
| TM_continue
  {
    $$ = (TContinue());
  }
| TM_break
  {
    $$ = (TBreak());
  }
| TM_return TM_IDENT
  {
    $$ = (TReturn($2));
  }

NT_EXPR:
  TM_NAT
  {
    $$ = (TConst($1));
  }
| TM_IDENT
  {
    $$ = (TVar($1));
  }
| TM_MINUS NT_EXPR %prec TM_UMINUS
  {
    $$ = (TUnOp(T_UMINUS,$2));
  }
| TM_MUL NT_EXPR  %prec TM_DEREF
  {
    $$ = (TDeref($2));
  }
| NT_EXPR TM_MUL NT_EXPR
  {
    $$ = (TBinOp(T_MUL,$1,$3));
  }
| NT_EXPR TM_PLUS NT_EXPR
  {
    $$ = (TBinOp(T_PLUS,$1,$3));
  }
| NT_EXPR TM_MINUS NT_EXPR
  {
    $$ = (TBinOp(T_MINUS,$1,$3));
  }
| NT_EXPR TM_DIV NT_EXPR
  {
    $$ = (TBinOp(T_DIV,$1,$3));
  }
| NT_EXPR TM_MOD NT_EXPR
  {
    $$ = (TBinOp(T_MOD,$1,$3));
  }
| NT_EXPR TM_LT NT_EXPR
  {
    $$ = (TBinOp(T_LT,$1,$3));
  }
| NT_EXPR TM_GT NT_EXPR
  {
    $$ = (TBinOp(T_GT,$1,$3));
  }
| NT_EXPR TM_LE NT_EXPR
  {
    $$ = (TBinOp(T_LE,$1,$3));
  }
| NT_EXPR TM_GE NT_EXPR
  {
    $$ = (TBinOp(T_GE,$1,$3));
  }
| NT_EXPR TM_EQ NT_EXPR
  {
    $$ = (TBinOp(T_EQ,$1,$3));
  }
| NT_EXPR TM_NE NT_EXPR
  {
    $$ = (TBinOp(T_NE,$1,$3));
  }
| NT_EXPR TM_AND NT_EXPR
  {
    $$ = (TBinOp(T_AND,$1,$3));
  }
| NT_EXPR TM_OR NT_EXPR
  {
    $$ = (TBinOp(T_OR,$1,$3));
  }
| TM_NOT NT_EXPR
  {
    $$ = (TUnOp(T_NOT,$2));
  }
| TM_and NT_EXPR
  {
    $$ = (TAddrOf($2));
  }
| TM_IDENT TM_LEFT_PAREN NT_el TM_RIGHT_PAREN
  {
    $$ = (TFunc($1,$3));
  }
| TM_IDENT TM_LEFT_PAREN TM_RIGHT_PAREN
  {
    $$ = (TFunc($1,TENil()));
  }  
;

NT_gi:
  TM_VAR TM_IDENT
  {
    $$ = (TGlobVar($2));
  }  
| TM_func TM_IDENT TM_LEFT_PAREN NT_vl TM_RIGHT_PAREN TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TFuncDef($2,$4,$7));
  }
| TM_proc TM_IDENT TM_LEFT_PAREN NT_vl TM_RIGHT_PAREN TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TProcDef($2,$4,$7));
  }
| TM_func TM_IDENT TM_LEFT_PAREN TM_RIGHT_PAREN TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TFuncDef($2,TVNil(),$6));
  }  
| TM_proc TM_IDENT TM_LEFT_PAREN TM_RIGHT_PAREN TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TProcDef($2,TVNil(),$6));
  }
| TM_NAT_RE TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TNatReDef($3));
  }
| TM_IDENT_RE TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TIdentReDef($3));
  }
| TM_BLANK_RE TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = (TBlankReDef($3));
  }
| TM_KEYWORD TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = ((TKeyWordDef($1, $3)));
  }
| TM_SYMBOL TM_LEFT_BRACE NT_CMD TM_RIGHT_BRACE
  {
    $$ = ((TSymbolDef($1, $3)));
  }
;
%%

void yyerror(char* s)
{
    fprintf(stderr , "%s\n", s);
}
