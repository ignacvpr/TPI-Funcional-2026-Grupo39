;; Sistema de Semáforos Inteligentes
;; Grupo 39 — Paradigmas y Lenguajes 2026


;; ========================================================
;; FUNCIÓN: transicion
;; NATURALEZA: Pura (siempre el mismo
;;             resultado. No imprime ni modifica nada mas)
;; ESTRATEGIA: Función Predicado
;; IMPACTO: No destructiva.
;; ========================================================

;;recibe el estado actual y al color que se quiere ir
;;retorna uan lista con el estado y una accion a realizar
(defun transicion (color-actual cambiar-a) 
  (cond

    ;; comprueba si esta en rojo y quiere ir a verde
    ((and (equal color-actual 'en-rojo)     (equal cambiar-a 'verde)) ;; equal compara si dos simbolos son exactamente el mismo
     (list color-actual "cambiar-a-verde"))

    ;;comprueba si esta en verde y quiere ir a amarillo
    ((and (equal color-actual 'en-verde)    (equal cambiar-a 'amarillo))
     (list color-actual "cambiar-a-amarillo"))

    ;; comprueba si esta en amarillo y quiere i a rojo
    ((and (equal color-actual 'en-amarillo) (equal cambiar-a 'rojo))
     (list color-actual "cambiar-a-rojo"))

    ;;retorna color actual y 'accion-por-defecto si la transición no es válida
    (t
     (list color-actual 'accion-por-defecto))))





;; ========================================================
;; FUNCIÓN: timer
;; NATURALEZA: Pura — mismo timestamp siempre devuelve
;;             el mismo color. No modifica nada externo.
;; ESTRATEGIA: Condicional simple
;; IMPACTO: No destructiva
;; ========================================================

;; recibe un tiempo Unix y devuelve el color correspondiente al momento especifico
(defun timer (tiempo-unix)

  ;; calcula en que punto del ciclo de 216 segundos estamos
  (let ((posicion (mod tiempo-unix 216)))

    ;; comparamos la pocision con el rango de cada color 
    (cond

      ;; 0 a 89 segundos, rojo (dura 90 segundos)
      ((< posicion 90)  'en-rojo)

      ;; 90 a 95 segundos, amarillo (dura 6 segundos)
      ((< posicion 96)  'en-amarillo)

      ;; 96 a 215 segundos, verde (dura 120 segundos)
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

;; FUNCIÓN: log-historial
;; NATURALEZA: Impura (efecto secundario: escribe en terminal y en archivo)
;; ESTRATEGIA: Función de Orden Superior (utiliza mapcar)
;; IMPACTO: No Destructiva
(defun log-historial (registros)
  (mapcar (lambda (registro)
            (log-cambio-estado
              (first registro)
              (second registro)))
          registros))
