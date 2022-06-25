/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname 
   FROM 
       u 
   WHERE 
       SUBSTRING(firstname, 0, 1) >= 'm';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.csv' USING PigStorage(',')
AS (col1:int, col2:chararray, col3:chararray, col4:chararray, col5:chararray, col6:int);

trans1 = FOREACH datos GENERATE col2 AS firstname;
trans2 = FOREACH trans1 GENERATE SUBSTRING(firstname,0,(int)SIZE(firstname)) AS name;
--trans2 = FILTER trans1 BY (firstname >='m');
--trans2 = FOREACH trans1 GENERATE REGEX_EXTRACT(firstname MATCHES '[m-zM-Z]+).*',1);

STORE trans2 INTO 'output' USING PigStorage (',');

--cat output/part-m-*
--!rm *log *.pig *.csv
--b = foreach a generate $0.., (SUBSTRING($0,0,1)=='G'?'y':'n');
