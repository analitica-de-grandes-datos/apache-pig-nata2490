/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/
datos = LOAD 'data.tsv' USING PigStorage('\t')
AS (col1:chararray, col2:chararray, col3:int);
ordered_datos = ORDER datos BY col1 , col3;

STORE ordered_datos INTO 'output' USING PigStorage (',');
--cat output/part-r-*
--!rm *log *.pig *.csv