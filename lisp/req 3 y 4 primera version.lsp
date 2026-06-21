;; ========================================================
;; FUNCIÓN: sistema-auditoria
;; NATURALEZA: Impura (Efecto secundario: realiza operaciones de E/S en terminal)
;; ESTRATEGIA: Función Simple / Secuencial
;; IMPACTO: No Destructiva
;; ========================================================
(defun sistema-auditoria (luz1 luz2)
  (let ((fecha (local-time:format-timestring nil (local-time:now))))
    (format t "~%Tiempo [~A]: la luz ha cambiado de ~A a ~A" fecha luz1 luz2)))

;; ========================================================
;; FUNCIÓN: duracion-cliclo
;; NATURALEZA: Pura (Función matemática simple de aridad 3)
;; ESTRATEGIA: Función Simple / Secuencial
;; IMPACTO: No Destructiva
;; ========================================================
(defun duracion-ciclo (rojo verde amarillo) 
  (+ rojo verde amarillo))

;; ========================================================
;; FUNCIÓN: recomendacion-ciclo
;; NATURALEZA: Pura (Evaluación lógica estricta basada únicamente en sus argumentos)
;; ESTRATEGIA: Función Condicional (Uso de la macro cond)
;; IMPACTO: No Destructiva
;; ========================================================
(defun recomendacion-ciclo (tiempo-total)
  (cond
    ((< tiempo-total 35) "El ciclo es muy corto")
    ((and (>= tiempo-total 35) (<= tiempo-total 150)) "Ciclo perfecto")
    ((> tiempo-total 150) "Ciclo demasiado largo")))
