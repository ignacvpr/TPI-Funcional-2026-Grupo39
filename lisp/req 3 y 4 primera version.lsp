;; =========================================================
;; REQUERIMIENTOS 3 Y 4 — SÓLO TU PARTE PARA PRUEBAS
;; Facundo — Paradigmas y Lenguajes
;; =========================================================

(ql:quickload "local-time")

;; ========================================================
;; FUNCIÓN: log-cambio-estado
;; NATURALEZA: Impura 
;; ESTRATEGIA: Función Simple 
;; IMPACTO: No Destructiva
;; ========================================================
(defun log-cambio-estado (color-anterior color-nuevo)
  (multiple-value-bind (segundo minuto hora dia mes ano) (get-decoded-time)
    (let ((fecha (format nil "~4,'0D-~2,'0D-~2,'0D T ~2,'0D:~2,'0D:~2,'0D" 
                         ano mes dia hora minuto segundo)))
      
      (format t "Tiempo [~A]: la luz ha cambiado de ~A a ~A~%" fecha color-anterior color-nuevo)
      
      (with-open-file (stream "informe-ejecucion-semaforo.txt"
                      :direction :output
                      :if-exists :append
                      :if-does-not-exist :create)
        (format stream "Tiempo [~A]: la luz ha cambiado de ~A a ~A~%" fecha color-anterior color-nuevo)))))


;; ========================================================
;; FUNCIÓN: duracion-ciclo
;; NATURALEZA: Pura 
;; ESTRATEGIA: Función Simple 
;; IMPACTO: No Destructiva
;; ========================================================
(defun duracion-ciclo (rojo verde amarillo) 
  (+ rojo verde amarillo))


;; ========================================================
;; FUNCIÓN: recomendacion-ciclo
;; NATURALEZA: Pura 
;; ESTRATEGIA: Función Condicional
;; IMPACTO: No Destructiva
;; ========================================================
(defun recomendacion-ciclo (tiempo-total)
  (cond
    ((< tiempo-total 35) "El ciclo es muy corto")
    ((and (>= tiempo-total 35) (<= tiempo-total 150)) "Ciclo perfecto")
    ((> tiempo-total 150) "Ciclo demasiado largo")))
