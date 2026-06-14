;; ========================================================
;; FUNCIÓN: sistema_auditoria
;; NATURALEZA: Impura (Efecto secundario: realiza operaciones de E/S en terminal)
;; ESTRATEGIA: Función Simple / Secuencial
;; IMPACTO: No Destructiva
;; ========================================================
(defun sistema_auditoria (luz1 luz2)
  (let ((fecha (local-time:format-timestring nil (local-time:now))))
    (format t "~%Tiempo [~A]: la luz ha cambiado de ~A a ~A" fecha luz1 luz2)))


;funcion a eliminar, solo se uso para comprobar funcionamiento
(defun duracion_ciclo () 
  (+ 90 6 120))


;; ========================================================
;; FUNCIÓN: recomendacion_ciclo
;; NATURALEZA: Pura (Evaluación lógica estricta basada únicamente en sus argumentos)
;; ESTRATEGIA: Función Condicional (Uso de la macro cond)
;; IMPACTO: No Destructiva
;; ========================================================
(defun recomendacion_ciclo (tiempo_total)
  (cond
    ((< tiempo_total 35) "El ciclo es muy corto")
    ((and (>= tiempo_total 35) (<= tiempo_total 150)) "Ciclo perfecto")
    ((> tiempo_total 150) "Ciclo demasiado largo")))