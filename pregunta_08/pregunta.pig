/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data= LOAD 'data.tsv' USING PigStorage('\t') AS (c1:chararray, c2:BAG{}, c3:MAP[]);
data_1 = FOREACH data GENERATE c1, SIZE(c2), SIZE(c3);
ordered_data = ORDER data_1 BY $0 asc, $1 asc, $2 asc;
STORE ordered_data INTO 'output' USING PigStorage(',');

--cat output/part-m-*
--!rm *log *.pig *.csv
