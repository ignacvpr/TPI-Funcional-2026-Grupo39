;; ========================================================
;; EXTENSIÓN 1: INTERMITENCIA DE SEGURIDAD
;; ========================================================

;; ========================================================
;; FUNCIÓN: color-valido-p
;; NATURALEZA: Pura
;; ESTRATEGIA: Función Predicado
;; IMPACTO: No Destructiva
;; ========================================================

(defun color-valido-p (color)
  (member color
          '(en-rojo
            en-amarillo
            en-verde
            en-amarillo-intermitente)))


;; ========================================================
;; FUNCIÓN: timer
;; NATURALEZA: Pura
;; ESTRATEGIA: Función Condicional (uso de cond)
;; IMPACTO: No Destructiva
;; ========================================================

(defun timer (tiempo-unix)
  (let ((posicion (mod tiempo-unix 222)))
    (cond
      ((< posicion 90) 'en-rojo)
      ((< posicion 93) 'en-amarillo-intermitente)
      ((< posicion 213) 'en-verde)
      ((< posicion 219) 'en-amarillo)
      (t 'en-amarillo-intermitente))))
