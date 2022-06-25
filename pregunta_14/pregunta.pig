/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/
datos = LOAD 'data.csv' USING PigStorage(',')
AS (col1:int, col2:chararray, col3:chararray, col4:chararray, col5:chararray, col6:int);

trans1 = FOREACH datos GENERATE col5 AS color;
trans2 = FILTER trans1 BY NOT (color MATCHES '(?i).*b.*');

STORE trans2 INTO 'output' USING PigStorage (',');

--cat output/part-m-*
--!rm *log *.pig *.csv

