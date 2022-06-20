/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' USING PigStorage('\t')
AS (col1:chararray, col2:chararray, col3:int);
foreach_datos = FOREACH datos GENERATE col3;
ordered_datos = ORDER foreach_datos BY col3 ASC;
lim_ordered_datos = LIMIT ordered_datos 5;

STORE lim_ordered_datos INTO 'output' USING PigStorage (',');
--cat output/part-r-*
--!rm *log *.pig *.csv