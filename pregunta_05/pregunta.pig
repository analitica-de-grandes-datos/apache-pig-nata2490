/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' USING PigStorage('\t')
AS (col1:chararray, col2:chararray, col3:chararray);
trans1 = FOREACH datos GENERATE REPLACE(col2,'[\\\'\\{\\}]+','');
trans2 = FOREACH trans1 GENERATE REPLACE(*, '[\\\'\\(\\)]+','');
trans3 = FOREACH trans2 GENERATE REPLACE(*, '\\,',' ');
--AS (col1:chararray, col2:BAG{T:tuple(t1:chararray, t2:chararray, t3:chararray, t4:chararray)}, col3:MAP[]);
trans4 = FOREACH trans3 GENERATE FLATTEN(TOKENIZE(*)) AS letter;
grouped_letters = GROUP trans4 BY letter;
letter_count = FOREACH grouped_letters GENERATE group, COUNT(trans4);
--lower_data = FOREACH letters GENERATE LOWER(letters);

STORE letter_count INTO 'output' USING PigStorage (',');

--cat output/part-r-*
--!rm *log *.pig *.csv