/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.csv' USING PigStorage(',')
AS (col1:int, col2:chararray, col3:chararray, col4:chararray, col5:chararray, col6:int);

trans1 = FOREACH datos GENERATE col4 AS birthday;
trans2 = FOREACH trans1 GENERATE SUBSTRING(birthday,5,7);
--trans2 = FOREACH trans1 GENERATE REGEX_EXTRACT(birthday,'\\w{4}\\w{2}\\w{2}\\s',1);
--trans2 = FOREACH trans1 GENERATE REGEX_EXTRACT(birthday,'(.*\-.*\-.*)\\s',1);

STORE trans2 INTO 'output' USING PigStorage (',');

--cat output/part-m-*
--!rm *log *.pig *.csv


