CREATE OR REPLACE VIEW saber11.v_ml_dataset AS
SELECT
  punt_global,
  estrato,
  personas_hogar,
  cuartos_hogar,
  edu_madre,
  edu_padre,
  tiene_internet::int                                         AS tiene_internet,
  tiene_computador::int                                       AS tiene_computador,
  tiene_automovil::int                                        AS tiene_automovil,
  tiene_lavadora::int                                         AS tiene_lavadora,
  cole_naturaleza,
  cole_area,
  cole_jornada,
  cole_bilingue,
  cole_caracter,
  cole_depto
FROM saber11.base
WHERE punt_global IS NOT NULL
  AND anio >= 2015
  AND estrato IS NOT NULL
  AND edad BETWEEN 14 AND 25;