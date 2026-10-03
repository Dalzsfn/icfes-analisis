CREATE OR REPLACE VIEW saber11.v_desempeno_anual AS
SELECT
  anio,
  count(*)                                          AS evaluados,
  round(avg(punt_global),1)                         AS global_prom,
  round(stddev_samp(punt_global),1)                 AS global_sd,
  round(percentile_cont(0.5) WITHIN GROUP (ORDER BY punt_global)::numeric,1) AS global_mediana,
  round(avg(punt_lectura),1)    AS lectura_prom,
  round(avg(punt_mate),1)       AS mate_prom,
  round(avg(punt_naturales),1)  AS naturales_prom,
  round(avg(punt_sociales),1)   AS sociales_prom,
  round(avg(punt_ingles),1)     AS ingles_prom
FROM saber11.base
WHERE punt_global IS NOT NULL
GROUP BY anio
ORDER BY anio;
 

CREATE OR REPLACE VIEW saber11.v_socioeconomico AS
SELECT
  anio,
  estrato,
  count(*)                                              AS evaluados,
  round(avg(punt_global),1)                             AS global_prom,
  round(100.0*avg(tiene_internet::int),1)               AS pct_internet,
  round(100.0*avg(tiene_computador::int),1)             AS pct_computador,
  round(100.0*avg(tiene_automovil::int),1)              AS pct_automovil
FROM saber11.base
WHERE punt_global IS NOT NULL AND estrato IS NOT NULL
GROUP BY anio, estrato
ORDER BY anio, estrato;

 
CREATE OR REPLACE VIEW saber11.v_educacion_padres AS
SELECT
  GREATEST(edu_madre, edu_padre)  AS edu_max_padres,   -
  count(*)                        AS evaluados,
  round(avg(punt_global),1)       AS global_prom,
  round(avg(punt_mate),1)         AS mate_prom,
  round(avg(punt_lectura),1)      AS lectura_prom
FROM saber11.base
WHERE punt_global IS NOT NULL AND GREATEST(edu_madre, edu_padre) IS NOT NULL
GROUP BY 1
ORDER BY 1;
 

CREATE OR REPLACE VIEW saber11.v_colegios AS
SELECT
  anio, cole_dane, cole_nombre, cole_naturaleza, cole_area, cole_depto, cole_mcpio,
  count(*)                    AS evaluados,
  round(avg(punt_global),1)   AS global_prom,
  round(avg(punt_ingles),1)   AS ingles_prom
FROM saber11.base
WHERE punt_global IS NOT NULL AND cole_dane IS NOT NULL
GROUP BY anio, cole_dane, cole_nombre, cole_naturaleza, cole_area, cole_depto, cole_mcpio
HAVING count(*) >= 10;
 

CREATE OR REPLACE VIEW saber11.v_brecha_colegio AS
SELECT
  anio, cole_naturaleza, cole_area,
  count(*)                    AS evaluados,
  round(avg(punt_global),1)   AS global_prom,
  round(avg(punt_mate),1)     AS mate_prom,
  round(avg(punt_lectura),1)  AS lectura_prom
FROM saber11.base
WHERE punt_global IS NOT NULL
GROUP BY anio, cole_naturaleza, cole_area
ORDER BY anio, cole_naturaleza, cole_area;
 

CREATE OR REPLACE VIEW saber11.v_geografia AS
SELECT
  anio, cole_depto,
  count(*)                    AS evaluados,
  round(avg(punt_global),1)   AS global_prom,
  round(avg(punt_ingles),1)   AS ingles_prom,
  round(100.0*avg(tiene_internet::int),1) AS pct_internet
FROM saber11.base
WHERE punt_global IS NOT NULL AND cole_depto IS NOT NULL
GROUP BY anio, cole_depto
ORDER BY anio, global_prom DESC;
