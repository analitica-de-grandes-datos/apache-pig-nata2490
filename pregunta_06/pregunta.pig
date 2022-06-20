/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' USING PigStorage('\t')
AS (col1:chararray, col2:chararray, col3:chararray);
trans1 = FOREACH datos GENERATE REPLACE(col3,'[\\\'\\[\\]]+','');
trans2 = FOREACH trans1 GENERATE FLATTEN(TOKENIZE(*));
trans3 = FOREACH trans2 GENERATE REPLACE(*, '\\#',' ');
trans4 = FOREACH trans3 GENERATE REGEX_EXTRACT(*,'(\\w+).*',1) AS letter;

grouped_letters = GROUP trans4 BY letter;
count_letters = FOREACH grouped_letters GENERATE group, COUNT(trans4);

STORE count_letters INTO 'output' USING PigStorage (',');

--cat output/part-r-*
--!rm *log *.pig *.csv

