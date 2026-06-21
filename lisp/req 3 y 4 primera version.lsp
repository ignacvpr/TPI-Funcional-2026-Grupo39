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
  (let ((fecha (local-time:format-timestring nil (local-time:now))))
    ;; Imprime el aviso en la consola
    (format t "Tiempo [~A]: la luz ha cambiado de ~A a ~A~%" fecha color-anterior color-nuevo)
    ;; Guarda el registro en el archivo de texto
    (with-open-file (stream "informe-ejecucion-semaforo.txt"
                    :direction :output
                    :if-exists :append
                    :if-does-not-exist :create)
      (format stream "Tiempo [~A]: la luz ha cambiado de ~A a ~A~%" fecha color-anterior color-nuevo))))


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
