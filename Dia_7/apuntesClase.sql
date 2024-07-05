-- ###############################
-- ## DIA 7 - MySQL 2 - Trabajo ##
-- ###############################

use world;

show tables;

-- Nombre del pais con más poblacion
select Name -- , Population
from country
where Population = (select max(Population) from country);

-- Listar las ciudades que tengan la misma población que la capital del país 'JPN' (Japon)
select Name
from city
where Population = (select Population from city where ID =(
select Capital from country where code = 'JPN'));

-- Encuentre los nombre de todas las ciudades en los paises que tienen un área mayor a 1000000 km2
select Name
from city
where CountryCode in (select code from country where SurfaceArea > 1000000);

-- Subconsultas de  multiples columnas: devuelve múltiples columnas de multiples filas
-- Ejemplo: Encontrar las ciudades que tengan la misma población y distrito que cualquier ciudad del pais. 'USA'
select Name, CountryCode,District,Population
from city
where (District,Population) in (select District,Population from
city where CountryCode = 'USA');

-- Subconsulta correlacionada: Depende de la counsulta externa para cada fila procesada.
-- Ejemplo: Liste las ciudades con una población mayor que el promedio de la problación de las ciudades en el mismo pais 
select Name,CountryCode,Population
from city c1
where Population > (select avg(Population) from city c2 where c1.CountryCode = c2.CountryCode);

-- Indexació
select * from city;

-- La indexación construye una estructura de datos que minimiza la cantidad de datos que hay que buscar organizándolos sistemáticamente,
-- lo que permite una ejecución más rápida y eficaz de las consultas. 
-- Vista previa de la tabla Cliente en MySQL Workbench.

-- Crear índice en la columna 'Name' de city
create index idx_city_name on city(Name);
select * from city;
select Name from city;

-- Crear índice compuesto de las columnas 'District' y 'Population'
create index idx_city_district_population on city(District,Population);

-- Datos estaticos para ver los indices creados

select 
    table_Name, 
    INDEX_NAME, 
    SEQ_IN_INDEX, 
    column_Name,
    CARDINALITY, 
    SUB_PART, 
    INDEX_TYPE, 
    comment
from 
    information_schema.STATISTICS
where 
    TABLE_SCHEMA = 'world';
-- Revisar tamaño de Indexaciones creadas
select 
    table_Name, 
    INDEX_LENGTH 
from 
    information_schema.tables 
where
    TABLE_SCHEMA = 'world';

-- Transacciones
-- Son secuencias de uno o más operaciones SQL, las cuales son ejecutadas como
-- una única unidad de trabajo. En otras palabras, las trasaccionesn aseguran que todas las operaciones
-- se realicen de manera correcta antes de ser ejecutads en la bbdd real, buscabdo cumplir con las propiedades
-- ACID. (ATOMICIDAD, CONSISTENCIA, AISLAMIENTO, DURABILIDAD).	

-- Primer paso: Iniciar la transación
start transaction;
-- Segundo paso: Hacer comandos
-- Ej: Actualizar la población de la ciudad de 'New York'
update city
set population = 92500000
where Name = 'New York';

select * from city where Name = 'New York';

-- Tercer paso: Si quiero que los cambios se mantengan pongo Commi, sino
-- revierto mis cambios con ROLLBACK.
commit; -- Mandar cambios a producción
rollback; -- Revertir cambios