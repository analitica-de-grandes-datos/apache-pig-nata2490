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
data_1 = FOREACH data GENERATE FLATTEN(c2),c3 AS c21;
data_2 = FOREACH data_1 GENERATE $0,FLATTEN($1) AS c31;
grouped= GROUP data_2 BY ($0,$1);
counter= FOREACH grouped GENERATE group, COUNT(data_2);
STORE counter INTO 'output' USING PigStorage(',');

--cat output/part-m-*
--!rm *log *.pig *.csv
