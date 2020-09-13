%{
int chars = 0; 		/* Here we are declaring and initializing counters */
int lines = 1; 		/* Here we are declaring and initializing counters */
int errors = 0; 	/* Here we are declaring and initializing counters */

FILE *fp;			/* Initializes a file pointer */
%}

/*Here we are declaring the rules of the grammar*/

%%
"=" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);} 										/* Here we are declaring that = is a legal token */
"{" 						{chars++; printf("%10s\t|\tLEFTCURLY\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tLEFTCURLY\t\t\t|\t%d\n",yytext,lines);} 								/* Here we are declaring that { is a legal token */
"}" 						{chars++; printf("%10s\t|\tRIGHTCURLY\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tRIGHTCURLY\t\t\t|\t%d\n",yytext,lines);} 								/* Here we are declaring that } is a legal token */
";" 						{chars++; printf("%10s\t|\tEND_SYMBOL\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tEND_SYMBOL\t\t\t|\t%d\n",yytext,lines);} 								/* Here we are declaring that ; is a legal token */
"(" 						{chars++; printf("%10s\t|\tLEFTPAREN\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tLEFTPAREN\t\t\t|\t%d\n",yytext,lines);} 								/* Here we are declaring that ( is a legal token */
")" 						{chars++; printf("%10s\t|\tRIGHTPAREN\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tRIGHTPAREN\t\t\t|\t%d\n",yytext,lines);} 								/* Here we are declaring that ) is a legal token */
"-" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
"!" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
"+" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
"*" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
"/" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
"==" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
"!=" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
"<" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
">" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
"<=" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
">=" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
"&&" 						{chars++; printf("%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tOPERATOR\t\t\t|\t%d\n",yytext,lines);}
int[a-zA-Z]{1,50} 		{errors++; chars += strlen(yytext); printf("%10s\t|\tERROR: DID USER MEAN TYPE INT?\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR: DID USER MEAN TYPE INT?\t|\t%d\n",yytext,lines);}
return[a-zA-Z]{1,50} 	{errors++; chars += strlen(yytext); printf("%10s\t|\tERROR AT LINE %d\t|\tDID USER MEAN RETURN?\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR AT LINE %d\t|\tDID USER MEAN RETURN?\n",yytext,lines);}
write[a-zA-Z]{1,50} 	{errors++; chars += strlen(yytext); printf("%10s\t|\tERROR AT LINE %d\t|\tDID USER MEAN WRITE?\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR AT LINE %d\t|\tDID USER MEAN WRITE?\n",yytext,lines);}
[0-9][a-zA-Z.]+ 		{chars++; errors++; printf("%10s\t|\tERROR: NUMBER BEFORE VAR NAME\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR: NUMBER BEFORE VAR NAME\t|\t%d\n",yytext,lines);}
int|float|char 				{chars += strlen(yytext); printf("%10s\t|\tType\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tType\t\t\t\t|\t%d\n",yytext,lines);} 							/* Here we are saying that the token int is a type token */
return|write|read|writeln|break|if|else|while 			{chars += strlen(yytext); printf("%10s\t|\tKeyword\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tKeyword\t\t\t\t|\t%d\n",yytext,lines);} 					/* Here we are saying that the tokens return and write are keywords */
[a-zA-Z]+ 				{chars += strlen(yytext); printf("%10s\t|\tIDENTIFIER\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tIDENTIFIER\t\t\t|\t%d\n",yytext,lines);} 	/* Here we are saying that a token made from a string of letters is an identifier */
[a-zA-Z][a-zA-Z0-9]+ 	{chars += strlen(yytext); printf("%10s\t|\tIDENTIFIER\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tIDENTIFIER\t\t\t|\t%d\n",yytext,lines);}
[0-9]+ 					{chars += strlen(yytext); printf("%10s\t|\tNUMBER\t\t\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tNUMBER\t\t\t\t|\t%d\n",yytext,lines);} 						/* A token created from a string of numbers is set as number */
\n 						{chars++; lines++;}
[ ]|[	] 				{chars++;} 																												/* All spaces and tabs will increase the chars counter by 1 */
. 						{chars++; errors++; printf("%10s\t|\tERROR: ILLEGAL CHARACTER\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR: ILLEGAL CHARACTER\t|\t%d\n",yytext,lines);}
;{2,100} 				{chars++; errors++; printf("%10s\t|\tERROR: EXTRA SEMICOLON\t\t|\t%d\n",yytext,lines); fprintf(fp,"%10s\t|\tERROR: EXTRA SEMICOLON\t\t|\t%d\n",yytext,lines);}

%%

main(int argc, char **argv)
{
if(argc > 1){
          if(!(yyin = fopen(argv[1],"r"))){
             perror(argv[1]);
             return(1);
          }
        }
		fp = fopen("Table.txt", "w");		/* Here we are creating the file table.txt that we are going to write too. */
        yylex();							/* This will run the lexer */
		fclose(fp);

printf("Lines: %8d\nChars: %8d\nErrors: %7d\n", lines,chars,errors);

}