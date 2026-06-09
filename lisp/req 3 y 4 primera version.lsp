(ql:quickload :local-time)

;; ========================================================
;; FUNCIÓN: sistema_auditoria
;; NATURALEZA: 
;; ESTRATEGIA: 
;; IMPACTO: 
;; ========================================================

(defun sistema_auditoria (luz1 luz2)
  (let ((fecha (local-time:format-timestring nil (local-time:now))))
    (format t "~%Tiempo [~A]: la luz ha cambiado de ~A a ~A" fecha luz1 luz2)))

(defun duracion_ciclo() ;funcion para pruebas, deberia reemplazarse por el requerimiento 2
  (+ 90 6 120))

;; ========================================================
;; FUNCIÓN: recomendacion_ciclo
;; NATURALEZA:
;; ESTRATEGIA: 
;; IMPACTO:
;; ========================================================

(defun recomendacion_ciclo (tiempo_total) ;tiempo_total = duracion_ciclo en la ejecucion
  (cond
    ((< tiempo_total 35) "El ciclo es muy corto")
    ((and (>= tiempo_total 35) (<= tiempo_total 150)) "Ciclo perfecto")
    ((> tiempo_total 150) "Ciclo demasiado largo")))