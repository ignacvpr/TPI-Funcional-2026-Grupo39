;; ========================================================
;; FUNCIÓN: sistema_auditoria
;; NATURALEZA: 
;; ESTRATEGIA: 
;; IMPACTO: 
;; ========================================================

(defun sistema_auditoria(tiempo luz1 luz2)
  (format t "~% Tiempo: ~A, La luz ha cambiado de ~A a ~A" tiempo luz1 luz2))

;; ========================================================
;; FUNCIÓN: duracion_ciclo
;; NATURALEZA:
;; ESTRATEGIA: 
;; IMPACTO: 
;; ========================================================

(defun duracion_ciclo()
  (+ 90 6 120))

;; ========================================================
;; FUNCIÓN: recomendacion_ciclo
;; NATURALEZA:
;; ESTRATEGIA: 
;; IMPACTO:
;; ========================================================

(defun recomendacion_ciclo(tiempo_total) ;tiempo_total = duracion_ciclo en la ejecucion
  (cond
    ((< tiempo_total 35) "El ciclo es muy corto")
    ((and (> tiempo_total 35) (< tiempo_total 150)) "Ciclo perfecto")
    ((> tiempo_total 150) "Ciclo demasiado largo")))