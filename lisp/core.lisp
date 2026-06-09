;; Sistema de Semáforos Inteligentes
;; Grupo 39 — Paradigmas y Lenguajes 2026


;; ========================================================
;; FUNCIÓN: transicion
;; NATURALEZA: Pura 
;; ESTRATEGIA: 
;; IMPACTO: 
;; ========================================================
(defun transicion (color-actual cambiar-a) 
  (cond
    ((and (eq color-actual 'en-rojo)     (eq cambiar-a 'verde)) 
     (list color-actual "cambiar-a-verde"))
    ((and (eq color-actual 'en-verde)    (eq cambiar-a 'amarillo))
     (list color-actual "cambiar-a-amarillo"))
    ((and (eq color-actual 'en-amarillo) (eq cambiar-a 'rojo))
     (list color-actual "cambiar-a-rojo"))
    (t
     (list color-actual 'accion-por-defecto))))


; FUNCIÓN: color-valido-p
;; NATURALEZA: Pura (sin efectos secundarios, mismo input = mismo output)
;; ESTRATEGIA: Función Predicado
;; IMPACTO: No Destructiva
;; ============================================================
(defun color-valido-p (color)
  "Verifica si el color dado es un estado válido del semáforo.
   Colores válidos: en-rojo, en-amarillo, en-verde"
  (member color '(en-rojo en-amarillo en-verde)))


;; ============================================================
;; FUNCIÓN: log-cambio-estado
;; NATURALEZA: Impura (efecto secundario: escribe en terminal)
;; ESTRATEGIA: Función Simple (no recursiva, no orden superior)
;; IMPACTO: No Destructiva

(defun log-cambio-estado (epoch color-anterior color-nuevo)
  "Registra en terminal el cambio de estado de un semáforo.
   Formato: 'Tiempo <epoch>: la luz ha cambiado de <anterior> a <nuevo>'
   Devuelve el registro como lista para permitir composición funcional."
  (cond
    ;; Validación: epoch debe ser entero positivo
    ((not (and (integerp epoch) (> epoch 0)))
     (format t "ERROR: El tiempo epoch debe ser un entero positivo~%")
     nil)
    ;; Validación: color anterior debe ser válido
    ((not (color-valido-p color-anterior))
     (format t "ERROR: Color anterior '~a' no es un estado valido~%" color-anterior)
     nil)
    ;; Validación: color nuevo debe ser válido
    ((not (color-valido-p color-nuevo))
     (format t "ERROR: Color nuevo '~a' no es un estado valido~%" color-nuevo)
     nil)
    ;; Caso válido: registra el cambio
    (t
     (format t "Tiempo ~a: la luz ha cambiado de ~a a ~a~%"
             epoch color-anterior color-nuevo)
     (list epoch color-anterior color-nuevo))))
