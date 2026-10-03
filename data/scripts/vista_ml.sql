CREATE OR REPLACE VIEW saber11.v_ml_dataset AS
SELECT
  punt_global,
  ntile(4) OVER (PARTITION BY anio ORDER BY punt_global)      AS rendimiento_cuartil,
  CASE WHEN anio <= 2018 THEN 'train' ELSE 'test' END         AS split,
  anio,
  genero,
  edad,
  estrato,
  personas_hogar,
  cuartos_hogar,
  edu_madre,
  edu_padre,
  GREATEST(edu_madre, edu_padre)                              AS edu_max_padres,
  tiene_internet::int                                         AS tiene_internet,
  tiene_computador::int                                       AS tiene_computador,
  tiene_automovil::int                                        AS tiene_automovil,
  tiene_lavadora::int                                         AS tiene_lavadora,
  (tiene_internet::int + tiene_computador::int
   + tiene_automovil::int + tiene_lavadora::int)              AS indice_bienes,
  cole_naturaleza,
  cole_area,
  cole_calendario,
  cole_jornada,
  cole_bilingue,
  cole_caracter,
  cole_genero,
  cole_depto
FROM saber11.base
WHERE punt_global IS NOT NULL
  AND anio >= 2015
  AND estrato IS NOT NULL
  AND edad BETWEEN 14 AND 25;