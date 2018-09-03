
%%

%integer

%%

[a-z][a-z0-9]* { return 1; }
[0-9]+         { return 2; }
[ \t\n\r]+     { /* do nnothing */ }
.              { System.out.printf("error: unexpected char |%s|\n",
                                   yytext()); }
