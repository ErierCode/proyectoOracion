
/* --------------------------Codigo de Usuario----------------------- */
package ejemplocup;

import java_cup.runtime.*;
import java.io.Reader;
      
%% //inicio de opciones
   
/* ------ Seccion de opciones y declaraciones de JFlex -------------- */  
   
/* 
    Cambiamos el nombre de la clase del analizador a Lexer
*/
%class AnalizadorLexico

/*
    Activar el contador de lineas, variable yyline
    Activar el contador de columna, variable yycolumn
*/
%line
%column
    
/* 
   Activamos la compatibilidad con Java CUP para analizadores
   sintacticos(parser)
*/
%cup
   
/*
    Declaraciones

    El codigo entre %{  y %} sera copiado integramente en el 
    analizador generado.
*/
%{
    /*  Generamos un java_cup.Symbol para guardar el tipo de token 
        encontrado */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /* Generamos un Symbol para el tipo de token encontrado 
       junto con su valor */
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
   

/*
    Macro declaraciones
  
    Declaramos expresiones regulares que despues usaremos en las
    reglas lexicas.
*/
   
/*  Un salto de linea es un \n, \r o \r\n dependiendo del SO   */
Salto = \r|\n|\r\n
   
/* Espacio es un espacio en blanco, tabulador \t, salto de linea 
    o avance de pagina \f, normalmente son ignorados */
Espacio     = {Salto} | [ \t\f]
   
/* EXPRESIONES REGULARES */
Entero = 0 | [1-9][0-9]*
Identificador =[a-zA-Z][A-Za-z0-9]* 
NumReal=({Entero}+) "." ({Entero}*)





%% //fin de opciones
/* -------------------- Seccion de reglas lexicas ------------------ */
   
/*
   Esta seccion contiene expresiones regulares y acciones. 
   Las acciones son código en Java que se ejecutara cuando se
   encuentre una entrada valida para la expresion regular correspondiente */
   
   /* YYINITIAL es el estado inicial del analizador lexico al escanear.
      Las expresiones regulares solo serán comparadas si se encuentra
      en ese estado inicial. Es decir, cada vez que se encuentra una 
      coincidencia el scanner vuelve al estado inicial. Por lo cual se ignoran
      estados intermedios.*/
   
<YYINITIAL> {
   
  
    /* 							DECLARANDO SIMBOLOS           */

    ";"                {  System.out.print(" ; ");
                          return symbol(sym.PUNTOYCOMA); }

    
    /* 					PALABRAS RESERVADAS 						*/
    "el" | "El"        {  System.out.print(" el ");
                          return symbol(sym.ARTICULO_EL); }

    "la"  | "La"          {  System.out.print(" la ");
                          return symbol(sym.ARTICULO_LA); }


    "niña"               {  System.out.print(" niña ");
                          return symbol(sym.NOMBRE_NINA); }

    "niño"               {  System.out.print(" niño ");
                          return symbol(sym.NOMBRE_NINO); }
    "carro"           {  System.out.print(" carro ");
                          return symbol(sym.NOMBRE_CARRO); }                      


    "es"               {  System.out.print(" es ");
                          return symbol(sym.VERBO_ES); }

    "corre"               {  System.out.print(" corre ");
                          return symbol(sym.VERBO_CORRE); }


    "obediente"               {  System.out.print(" obediente ");
                          return symbol(sym.ADJ_OBDIENTE); }

     "bonita"               {  System.out.print(" bonita ");
                          return symbol(sym.ADJ_BONITA); }   

    "rapido"               {  System.out.print(" rapido ");
                          return symbol(sym.ADJ_RAPIDO); }                      

    /* No hace nada si encuentra el espacio en blanco */
    {Espacio}       { /* ignora el espacio */ } 
}


/* Si el token contenido en la entrada no coincide con ninguna regla
    entonces se marca un token ilegal */
[^]                    { throw new Error("Caracter ilegal <"+yytext()+">"); }
