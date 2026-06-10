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



   ;; ========================================================
;; FUNCIÓN: timer
;; NATURALEZA: 
;; ESTRATEGIA: 
;; IMPACTO: No destructiva
;; ========================================================
(defun timer (tiempo-unix)
  (let ((posicion (mod tiempo-unix 216)))
    (cond
      ((< posicion 90)  'en-rojo)
      ((< posicion 96)  'en-amarillo)
      (t  'en-verde)
      )
    )
  )





; FUNCIÓN: color-valido-p
;; NATURALEZA: Pura (sin efectos secundarios, mismo input = mismo output)
;; ESTRATEGIA: Función Predicado
;; IMPACTO: No Destructiva
;; ============================================================
(defun color-valido-p (color)
  "Verifica si el color dado es un estado válido del semáforo.
   Colores válidos: en-rojo, en-amarillo, en-verde"
  (member color '(en-rojo en-amarillo en-verde)))


;; ========================================================
;; FUNCIÓN: log-cambio-estado
;; NATURALEZA: Impura (escribe en pantalla y en archivo)
;; ESTRATEGIA: Funcion Simple
;; IMPACTO: No destructiva
;; ========================================================
;; se modifico esta funcion para usar local-time en lugar de epoch
;; ahora obtiene la fecha automaticamente con local-time:now
;; y ademas guarda el registro en un archivo de texto
(ql:quickload :local-time)

(defun log-cambio-estado (color-anterior color-nuevo)
  (let ((fecha (local-time:format-timestring nil (local-time:now))))
    ;; imprime en pantalla
    (format t "Tiempo [~A]: la luz ha cambiado de ~A a ~A~%" fecha color-anterior color-nuevo)
    ;; guarda en archivo
    (with-open-file (stream "informe-ejecucion-semaforo.txt"
                    :direction :output
                    :if-exists :append
                    :if-does-not-exist :create)
      (format stream "Tiempo [~A]: la luz ha cambiado de ~A a ~A~%" fecha color-anterior color-nuevo))))
