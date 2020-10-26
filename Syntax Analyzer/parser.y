%{
//#include "symtab.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE *yyin;
extern FILE *yyout;
extern int lines;
extern int yylex();
void yyerror();
%}

/* declare tokens */
%token CONSTANT
%token INT CHAR
%token LEFTCURLY RIGHTCURLY
%token END_SYMBOL
%token LEFTPAREN RIGHTPAREN
%token EQUAL MINUS PLUS EXCLAM ASTERISK SLASH DEQUAL NEQUAL LESS GREATER LESSEQUAL GREATEREQUAL DAND OR 
%token COMMA
%token LEFTBRACK RIGHTBRACK
%token RETURN WRITE READ WRITELN BREAK IF ELSE WHILE
%token PRINTF
%token ID

%%

Program: VarDeclList
 | FunDeclList
 ;

VarDeclList: /*nothing*/
 | VarDecl VarDeclList
 ;

VarDecl: Type ID X1
 ;
 
X1: END_SYMBOL
 | LEFTBRACK CONSTANT RIGHTBRACK END_SYMBOL

FunDeclList: FunDecl X2
 ;

X2: /*nothing*/
 | FunDeclList
 ;
 
FunDecl: Type ID LEFTPAREN ParamDeclList RIGHTPAREN Block 
 ;

ParamDeclList: /*nothing*/
 | ParamDeclListTail
 ;

ParamDeclListTail: ParamDecl X3
 ;
 
X3: /*nothing*/
 | COMMA ParamDeclListTail
 ;
 
ParamDecl: Type ID X4
 ;

X4: /*nothing*/
 | LEFTBRACK RIGHTBRACK
 ;
 
Block: LEFTCURLY VarDeclList StmtList RIGHTCURLY
 ;

Type: INT
 | CHAR
 ;

StmtList: Stmt X5
 ;

X5: /*nothing*/
 | StmtList
 ;
 
Stmt: END_SYMBOL
 | Astmt END_SYMBOL
 | RETURN Expr END_SYMBOL
 | READ ID END_SYMBOL
 | WRITE Expr END_SYMBOL
 | WRITELN END_SYMBOL
 | BREAK END_SYMBOL
 | IF LEFTPAREN Expr RIGHTPAREN Stmt ELSE Stmt
 | WHILE LEFTPAREN Expr RIGHTPAREN Stmt
 | Block
 ;

Astmt: ID X7
 
Expr: Primary X6
 | UnaryOP Expr X6
 ;

X6: /*nothing*/
 | BinOP Expr X6
 ;

X7: EQUAL Expr X6
 | LEFTBRACK Expr RIGHTBRACK EQUAL Expr X6
 ;
 
Primary: ID X8
 | CONSTANT
 | LEFTPAREN Expr RIGHTPAREN
 ;
 
X8: /*nothing*/
 | LEFTPAREN ExprList RIGHTPAREN
 | LEFTBRACK Expr RIGHTBRACK
 ; 

ExprList: /*nothing*/
 | ExprListTail
 ;

ExprListTail: Expr X9
 ;

X9: /*nothing*/
 | COMMA ExprListTail
 ;
 
UnaryOP: MINUS
 | EXCLAM
 ;

BinOP: PLUS
 | MINUS
 | ASTERISK
 | SLASH
 | DEQUAL
 | NEQUAL
 | LESS
 | LESSEQUAL
 | GREATER
 | GREATEREQUAL
 | DAND
 | OR
 ;
 
%%

void yyerror ()
{
  fprintf(stderr, "Syntax error at line %d\n", lines);
  exit(1);
}

int main (int argc, char *argv[])
{
	//initialize symbol table
//	init_hash_table();
	
    // parsing
    int flag;
    yyin = fopen(argv[1], "r");
    flag = yyparse();
    fclose(yyin);

	/*
	// symbol table dump
	yyout = fopen("symtab_dump.out", "w");
	symtab_dump(yyout);
	fclose(yyout);
	*/
    
    return flag;
}