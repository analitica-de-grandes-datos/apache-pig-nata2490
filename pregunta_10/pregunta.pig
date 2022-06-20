/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.csv' USING PigStorage(',')
AS (col1:int, col2:chararray, col3:chararray, col4:chararray, col5:chararray, col6:int);
trans1 = FOREACH datos GENERATE col3 AS lastname, SIZE(col3);
trans2 = FILTER trans1
BY (
  lastname == 'Hamilton' OR
  lastname == 'Garrett' OR
  lastname == 'Holcomb' OR
  lastname == 'Coffey' OR
  lastname == 'Conway'
  );

STORE trans2 INTO 'output' USING PigStorage (',');

--cat output/part-m-*
--!rm *log *.pig *.csv

