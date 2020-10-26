%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include "symtab.h"
#include "parser.tab.h"
extern FILE *yyin;
extern FILE *yyout;
void ret_print(char *token_type);
void yyerror();

int chars = 0; 		/* Here we are declaring and initializing counters */
int lines = 1; 		/* Here we are declaring and initializing counters */
int errors = 0; 	/* Here we are declaring and initializing counters */

FILE *fp;			/* Initializes a file pointer */
%}

/*Here we are declaring the rules of the grammar*/

%%
"=" 						{chars++; printf("%10s\t|\tEQUAL\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tEQUAL\t\t\t|\t%d\n",yytext,lines); return EQUAL;} 										/* Here we are declaring that = is a legal token */
"{" 						{chars++; printf("%10s\t|\tLEFTCURLY\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tLEFTCURLY\t\t\t|\t%d\n",yytext,lines); return LEFTCURLY;} 								/* Here we are declaring that { is a legal token */
"}" 						{chars++; printf("%10s\t|\tRIGHTCURLY\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tRIGHTCURLY\t\t\t|\t%d\n",yytext,lines); return RIGHTCURLY;} 								/* Here we are declaring that } is a legal token */
";" 						{chars++; printf("%10s\t|\tEND_SYMBOL\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tEND_SYMBOL\t\t\t|\t%d\n",yytext,lines); return END_SYMBOL;} 								/* Here we are declaring that ; is a legal token */
"(" 						{chars++; printf("%10s\t|\tLEFTPAREN\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tLEFTPAREN\t\t\t|\t%d\n",yytext,lines); return LEFTPAREN;} 								/* Here we are declaring that ( is a legal token */
")" 						{chars++; printf("%10s\t|\tRIGHTPAREN\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tRIGHTPAREN\t\t\t|\t%d\n",yytext,lines); return RIGHTPAREN;} 								/* Here we are declaring that ) is a legal token */
"-" 						{chars++; printf("%10s\t|\tMINUS\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tMINUS\t\t\t|\t%d\n",yytext,lines); return MINUS;}
"!" 						{chars++; printf("%10s\t|\tEXCLAM\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tEXCLAM\t\t\t|\t%d\n",yytext,lines); return EXCLAM;}
"+" 						{chars++; printf("%10s\t|\tPLUS\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tPLUS\t\t\t|\t%d\n",yytext,lines); return PLUS;}
"*" 						{chars++; printf("%10s\t|\tASTERISK\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tASTERISK\t\t\t|\t%d\n",yytext,lines); return ASTERISK;}
"/" 						{chars++; printf("%10s\t|\tSLASH\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tSLASH\t\t\t|\t%d\n",yytext,lines); return SLASH;}
"==" 						{chars++; printf("%10s\t|\tDEQUAL\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tDEQUAL\t\t\t|\t%d\n",yytext,lines); return DEQUAL;}
"!=" 						{chars++; printf("%10s\t|\tNEQUAL\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tNEQUAL\t\t\t|\t%d\n",yytext,lines); return NEQUAL;}
"<" 						{chars++; printf("%10s\t|\tLESS\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tLESS\t\t\t|\t%d\n",yytext,lines); return LESS;}
">" 						{chars++; printf("%10s\t|\tGREATER\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tGREATER\t\t\t|\t%d\n",yytext,lines); return GREATER;}
"<=" 						{chars++; printf("%10s\t|\tLESSEQUAL\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tLESSEQUAL\t\t\t|\t%d\n",yytext,lines); return LESSEQUAL;}
">=" 						{chars++; printf("%10s\t|\tGREATEREQUAL\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tGREATEREQUAL\t\t\t|\t%d\n",yytext,lines); return GREATEREQUAL;}
"&&" 						{chars++; printf("%10s\t|\tDAND\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tDAND\t\t\t|\t%d\n",yytext,lines); return DAND;}
"[" 						{chars++; printf("%10s\t|\tLEFTBRACK\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tLEFTBRACK\t\t\t|\t%d\n",yytext,lines); return LEFTBRACK;}
"]" 						{chars++; printf("%10s\t|\tRIGHTBRACK\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tRIGHTBRACK\t\t\t|\t%d\n",yytext,lines); return RIGHTBRACK;}
"," 						{chars++; printf("%10s\t|\tCOMMA\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tCOMMA\t\t\t|\t%d\n",yytext,lines); return COMMA;}
"||" 						{chars++; printf("%10s\t|\tOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOR\t\t\t|\t%d\n",yytext,lines); return OR;}
int[a-zA-Z]{1,50} 		{errors++; chars += strlen(yytext); printf("%10s\t|\tERROR: DID USER MEAN TYPE INT?\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR: DID USER MEAN TYPE INT?\t|\t%d\n",yytext,lines);}
return[a-zA-Z]{1,50} 	{errors++; chars += strlen(yytext); printf("%10s\t|\tERROR AT LINE %d\t|\tDID USER MEAN RETURN?\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR AT LINE %d\t|\tDID USER MEAN RETURN?\n",yytext,lines);}
write[a-zA-Z]{1,50} 	{errors++; chars += strlen(yytext); printf("%10s\t|\tERROR AT LINE %d\t|\tDID USER MEAN WRITE?\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR AT LINE %d\t|\tDID USER MEAN WRITE?\n",yytext,lines);}
[0-9][a-zA-Z.]+ 		{chars++; errors++; printf("%10s\t|\tERROR: NUMBER BEFORE VAR NAME\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR: NUMBER BEFORE VAR NAME\t|\t%d\n",yytext,lines);}
int			{chars += strlen(yytext); printf("%10s\t|\tINT\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tINT\t\t\t\t|\t%d\n",yytext,lines); return INT;}
char 				{chars += strlen(yytext); printf("%10s\t|\tCHAR\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tCHAR\t\t\t\t|\t%d\n",yytext,lines); return CHAR;} 							/* Here we are saying that the token int is a type token */
return			{chars += strlen(yytext); printf("%10s\t|\tRETURN\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tRETURN\t\t\t\t|\t%d\n",yytext,lines); return RETURN;}
write			{chars += strlen(yytext); printf("%10s\t|\tWRITE\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tWRITE\t\t\t\t|\t%d\n",yytext,lines); return WRITE;}
read		{chars += strlen(yytext); printf("%10s\t|\tREAD\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tREAD\t\t\t\t|\t%d\n",yytext,lines); return READ;}
writeln			{chars += strlen(yytext); printf("%10s\t|\tWRITELN\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tWRITELN\t\t\t\t|\t%d\n",yytext,lines); return WRITELN;}
break		{chars += strlen(yytext); printf("%10s\t|\tBREAK\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tBREAK\t\t\t\t|\t%d\n",yytext,lines); return BREAK;}
if		{chars += strlen(yytext); printf("%10s\t|\tIF\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tIF\t\t\t\t|\t%d\n",yytext,lines); return IF;}
else		{chars += strlen(yytext); printf("%10s\t|\tELSE\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tELSE\t\t\t\t|\t%d\n",yytext,lines); return ELSE;}
while 			{chars += strlen(yytext); printf("%10s\t|\tWHILE\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tWHILE\t\t\t\t|\t%d\n",yytext,lines); return WHILE;}
printf 			{chars += strlen(yytext); printf("%10s\t|\tPRINTF\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tPRINTF\t\t\t\t|\t%d\n",yytext,lines); return PRINTF;}
[a-zA-Z]+ 				{chars += strlen(yytext); printf("%10s\t|\tID\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tID\t\t\t|\t%d\n",yytext,lines); return ID;/*insert(yytext, strlen(yytext), UNDEF, lines); return ID;*/} 	/* Here we are saying that a token made from a string of letters is an identifier */
[a-zA-Z][a-zA-Z0-9]+ 	{chars += strlen(yytext); printf("%10s\t|\tID\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tID\t\t\t|\t%d\n",yytext,lines); return ID; /*insert(yytext, strlen(yytext), UNDEF, lines); return ID;*/}
[0-9]+ 					{chars += strlen(yytext); printf("%10s\t|\tCONSTANT\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tCONSTANT\t\t\t\t|\t%d\n",yytext,lines); return CONSTANT;} 						/* A token created from a string of numbers is set as number */
\n 						{chars++; lines++;}
[ ]|[	] 				{chars++;} 																												/* All spaces and tabs will increase the chars counter by 1 */
. 						{chars++; errors++; printf("%10s\t|\tERROR: ILLEGAL CHARACTER\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR: ILLEGAL CHARACTER\t|\t%d\n",yytext,lines);}
;{2,100} 				{chars++; errors++; printf("%10s\t|\tERROR: EXTRA SEMICOLON\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR: EXTRA SEMICOLON\t\t|\t%d\n",yytext,lines);}

%%