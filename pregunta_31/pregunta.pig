/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.csv' USING PigStorage(',')
AS (col1:int, col2:chararray, col3:chararray, col4:datetime, col5:chararray, col6:int);

trans1 = FOREACH datos GENERATE col2, ToString(col4, 'yyyy') AS year;
trans2 = GROUP trans1 by (year);
trans3 = FOREACH trans2 GENERATE group AS (year), COUNT($1);

STORE trans3 INTO 'output' USING PigStorage (',');
--cat output/part-r-*
--!rm *log *.pig *.csv