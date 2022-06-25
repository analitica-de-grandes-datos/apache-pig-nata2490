/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

datos = LOAD 'data.tsv' USING PigStorage('\t')
AS (col1:chararray, col2:datetime, col3:int);
letters = GROUP datos BY col1;
count_letters = FOREACH letters GENERATE group as letter, COUNT(datos.col1);

STORE count_letters INTO 'output' USING PigStorage (',');