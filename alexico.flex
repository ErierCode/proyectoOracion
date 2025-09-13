/* --------------------------Codigo de Usuario----------------------- */
package ejemplocup;

import java_cup.runtime.*;
import java.io.Reader;
      
%% //inicio de opciones
   
%class AnalizadorLexico
%line
%column
%cup
   
%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline+1, yycolumn+1);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline+1, yycolumn+1, value);
    }
%}
   
/* ---------------- Macros ---------------- */
Salto        = \r|\n|\r\n
Espacio      = {Salto} | [ \t\f]
Entero       = 0 | [1-9][0-9]*
NumReal      = {Entero}"."{Entero}+
Identificador= [a-zA-Z][A-Za-z0-9]*
Cadena       = \'[^\']*\'

%% //fin de opciones
/* -------------------- Reglas lexicas ------------------ */

<YYINITIAL> {

    /* -------- PALABRAS RESERVADAS -------- */
    "program"   { return symbol(sym.PROGRAM); }
    "begin"     { return symbol(sym.BEGIN); }
    "end"       { return symbol(sym.END); }
    "writeln"   { return symbol(sym.WRITELN); }
    "write"     { return symbol(sym.WRITE); }
    "uses"      { return symbol(sym.USES); }
    "var"       { return symbol(sym.VAR); }
    "const"     { return symbol(sym.CONST); }
    "type"      { return symbol(sym.TYPE); }
    "integer"   { return symbol(sym.INTEGER); }
    "real"      { return symbol(sym.REAL); }
    "string"    { return symbol(sym.STRING); }

    /* -------- SÍMBOLOS -------- */
    ";"         { return symbol(sym.SEMI); }
    ":"         { return symbol(sym.DP); }
    ","         { return symbol(sym.COMA); }
    "."         { return symbol(sym.PUNTO); }
    "("         { return symbol(sym.PA); }
    ")"         { return symbol(sym.PC); }
    "["         { return symbol(sym.CORI); }
    "]"         { return symbol(sym.CORD); }
    "="         { return symbol(sym.IGUAL); }
    "+"         { return symbol(sym.MAS); }
    "-"         { return symbol(sym.MENOS); }
    "*"         { return symbol(sym.POR); }
    "/"         { return symbol(sym.DIV); }
    ".."        { return symbol(sym.RANGO); }

    /* -------- LITERALES -------- */
    {Cadena} {
        String s = yytext().substring(1, yytext().length()-1); // quitar comillas
        return symbol(sym.CADENA, s);
    }

    {NumReal}   { return symbol(sym.REALNUM, yytext()); }
    {Entero}    { return symbol(sym.INTNUM, yytext()); }
    {Identificador} { return symbol(sym.ID, yytext()); }

    /* -------- COMENTARIOS -------- */
    "//".*                  { /* ignorar */ }
    "\\{".*?"\\}"           { /* ignorar */ }
    "\\(\\*"([^*]|\\*+[^)])* "\\*\\)" { /* ignorar */ }

    /* -------- IGNORAR ESPACIOS -------- */
    {Espacio}   { /* ignora espacios */ }
}

/* -------- ERROR LÉXICO -------- */
[^] { throw new Error("Caracter ilegal <"+yytext()+"> en linea "+yyline+", columna "+yycolumn); }
