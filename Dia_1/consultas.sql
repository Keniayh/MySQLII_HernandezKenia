USE HOSPITAL;


SELECT m.nombre AS nombre_medico, COUNT(p.id_paciente) AS numero_pacientes
FROM medico m
LEFT JOIN paciente p ON m.id_medico = p.id_medico
GROUP BY m.id_medico, m.nombre;



SELECT e.nombre AS nombre_empleado, 
       SUM(DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1) AS dias_vacaciones
FROM empleado e
JOIN vacacion v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado, e.nombre;



SELECT m.nombre AS nombre_medico, 
       COUNT(c.id_consulta) * TIME_TO_SEC(c.horario) / 3600 AS horas_consulta
FROM medico m
JOIN consulta c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nombre
ORDER BY horas_consulta DESC
LIMIT 1;

SELECT m.nombre AS nombre_medico, COUNT(s.id_sustitucion) AS numero_sustituciones
FROM medico m
JOIN sustitucion s ON m.id_medico = s.id_medico
WHERE m.tipo = 'Sustituto'
GROUP BY m.id_medico, m.nombre;



SELECT COUNT(DISTINCT s.id_medico) AS medicos_en_sustitucion
FROM sustitucion s
WHERE s.fecha_baja IS NULL OR s.fecha_baja >= CURDATE();


SELECT m.nombre AS nombre_medico, c.dia_Semana, 
       COUNT(c.id_consulta) * TIME_TO_SEC(c.horario) / 3600 AS horas_consulta
FROM medico m
JOIN consulta c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, c.dia_Semana, m.nombre;


SELECT m.nombre AS nombre_medico, COUNT(p.id_paciente) AS numero_pacientes
FROM medico m
JOIN paciente p ON m.id_medico = p.id_medico
GROUP BY m.id_medico, m.nombre
ORDER BY numero_pacientes DESC
LIMIT 1;


SELECT e.nombre AS nombre_empleado, 
       SUM(DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1) AS dias_vacaciones
FROM empleado e
JOIN vacacion v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado, e.nombre
HAVING dias_vacaciones > 10;


SELECT e.nombre AS nombre_empleado, 
       SUM(DATEDIFF(v.fecha_fin, v.fecha_inicio) + 1) AS dias_vacaciones
FROM empleado e
JOIN vacacion v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado, e.nombre
HAVING dias_vacaciones > 10;



SELECT m.nombre AS nombre_medico
FROM medico m
JOIN sustitucion s ON m.id_medico = s.id_medico
WHERE s.fecha_baja IS NULL OR s.fecha_baja >= CURDATE();



SELECT m.nombre AS nombre_medico, c.dia_Semana, 
       AVG(TIME_TO_SEC(c.horario) / 3600) AS promedio_horas_consulta
FROM medico m
JOIN consulta c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, c.dia_Semana, m.nombre;

