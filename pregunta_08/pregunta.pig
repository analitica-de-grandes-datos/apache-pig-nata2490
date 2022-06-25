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

data = LOAD 'data.tsv' USING PigStorage('\t') AS (col1:chararray, col2:chararray,col3:chararray);
data_1= FOREACH data GENERATE FLATTEN(TOKENIZE(col2, ',')) AS cols_des, FLATTEN(TOKENIZE(col3, ',')) AS col3_des;
data_2 = FOREACH data_1 GENERATE REPLACE(col2_des, '([^a-zA-Z\\s]+)','') AS col1, REPLACE(col3_des,'([^a-zA-Z\\s]+)','') AS clave;
data_3 = FOREACH data_2 GENERATE TOTUPLE(col1,clave) AS tupla; 
my_group = GROUP data BY tupla;
my_count = FOREACH my_group GENERATE group, COUNT(data); 
STORE my_count INTO 'output' USING PigStorage(',');

--cat output/part-m-*
--!rm *log *.pig *.csv
