%{
#include<stdio.h>
#include<math.h>
#include <ctype.h>
#define YYSTYPE double
int yylex();
void yyerror(char *);
%}

%token NUM

%%
input:    /* empty string */
        | input line
;
line: '\n'
| exp '\n' { printf ("\t%.10g\n", $1); }
;
exp: NUM {$$ = $1;}
| exp exp '+' {$$ = $1+$2;}
| exp exp '-' {$$ = $1-$2;}
| exp exp '*' {$$ = $1*$2;}
| exp exp '/' {$$ = $1/$2;}
//| exp exp '^' { $$ = pow ($1, $2); }
| exp 'n'     { $$ = -$1;}
;
%%

int yylex ()
{
  int c;

  /* skip white space  */
  while ((c = getchar ()) == ' ' || c == '\t')  
    ;
  /* process numbers   */
  if (c == '.' || isdigit (c))                
    {
      ungetc (c, stdin);
      scanf ("%lf", &yylval);
      return NUM;
    }
  /* return end-of-file  */
  if (c == EOF)                            
    return 0;
  /* return single chars */
  return c;                                
}

void yyerror (char* s){  
  printf ("%s\n", s);
}
void main(){
yyparse();
}
