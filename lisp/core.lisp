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




;; FUNCIÓN: minutos-a-segundos
;; NATURALEZA: Pura
;; ESTRATEGIA: Función Simple
;; IMPACTO: No Destructiva
;; ============================================================
(defun minutos-a-segundos (minutos)
  "Convierte minutos a segundos.
   Entrada: cantidad de minutos (número positivo)
   Salida: equivalente en segundos"
  (* minutos 60))





;; ============================================================
;; FUNCIÓN: ciclos-por-tiempo
;; NATURALEZA: Pura (mismo input siempre devuelve mismo output)
;; ESTRATEGIA: Función Simple (operación aritmética directa)
;; IMPACTO: No Destructiva
;; ============================================================
(defun ciclos-por-tiempo (duracion-minutos)
  "Calcula cuántos ciclos semafóricos completos entran
   en una cantidad de minutos dada.
   Entrada: duración en minutos (número positivo)
   Salida: número de ciclos completos (entero)"
  (cond
    ; validación: la duración debe ser positiva
    ((not (and (numberp duracion-minutos)
               (> duracion-minutos 0)))
     (format t "ERROR: La duración debe ser un número positivo~%")
     nil)

    ; caso válido: calculamos los ciclos
    (t
     (let* (
       ; convertimos minutos a segundos
       (segundos-totales   (minutos-a-segundos duracion-minutos))

       ; duración de un ciclo completo con valores actuales
       (duracion-ciclo     (+ 90 6 120))

       ; dividimos y redondeamos hacia abajo
       (ciclos-completos   (floor (/ segundos-totales duracion-ciclo)))
     )
       ciclos-completos))))

;; ============================================================
;; FUNCIÓN: calcular-porcentaje
;; NATURALEZA: Pura (mismo input siempre devuelve mismo output)
;; ESTRATEGIA: Función Simple (operación aritmética directa)
;; IMPACTO: No Destructiva
;; ============================================================
(defun calcular-porcentaje (tiempo-color duracion-total)
  "Calcula el porcentaje de tiempo que ocupa un color
   dentro de la duración total de un ciclo."
  (* (/ (* tiempo-color 1.0) duracion-total) 100))


;; ============================================================
;; FUNCIÓN: duracion-ciclo-total
;; NATURALEZA: Pura
;; ESTRATEGIA: Función Simple
;; IMPACTO: No Destructiva
;; ============================================================
(defun duracion-ciclo-total (tiempo-rojo tiempo-amarillo tiempo-verde)
  "Calcula la duración total de un ciclo semafórico completo."
  (+ tiempo-rojo tiempo-amarillo tiempo-verde))


;; ============================================================
;; FUNCIÓN: informe-distribucion
;; NATURALEZA: Pura
;; ESTRATEGIA: Función de Orden Superior (utiliza mapcar)
;; IMPACTO: No Destructiva
;; ============================================================
(defun informe-distribucion (tiempo-rojo tiempo-amarillo tiempo-verde)
  "Calcula la distribución porcentual de cada color en 1 hora.
   Devuelve una lista de sublistas: (color porcentaje)
   Los tiempos se expresan en segundos."
  (let* (
    ; calculamos la duración total del ciclo
    (duracion-total (duracion-ciclo-total
                      tiempo-rojo
                      tiempo-amarillo
                      tiempo-verde))

    ; creamos la lista de colores con sus tiempos
    (colores-tiempos (list
                       (list 'rojo     tiempo-rojo)
                       (list 'amarillo tiempo-amarillo)
                       (list 'verde    tiempo-verde)))
  )
    ; usamos mapcar para calcular el porcentaje de cada color
    (mapcar (lambda (par)
              (list (car par)
                    (calcular-porcentaje (cadr par) duracion-total)))
            colores-tiempos)))


;; ============================================================
;; FUNCIÓN: distribucion-actual
;; NATURALEZA: Pura
;; ESTRATEGIA: Función Simple (wrapper con valores actuales)
;; IMPACTO: No Destructiva
;; ============================================================
(defun distribucion-actual ()
  "Calcula la distribución porcentual usando las reglas
   de negocio actuales: Rojo=90s, Amarillo=6s, Verde=120s"
  (informe-distribucion 90 6 120))


;; ============================================================
;; FUNCIÓN: imprimir-distribucion
;; NATURALEZA: Impura (efecto secundario: escribe en terminal)
;; ESTRATEGIA: Función de Orden Superior (utiliza mapcar)
;; IMPACTO: No Destructiva
;; ============================================================
(defun imprimir-distribucion (tiempo-rojo tiempo-amarillo tiempo-verde)
  "Muestra en terminal el informe de distribución temporal
   de forma legible para el operador."
  (let* ((distribucion (informe-distribucion
                          tiempo-rojo
                          tiempo-amarillo
                          tiempo-verde)))
    (format t "=== INFORME DE DISTRIBUCIÓN TEMPORAL (1 hora) ===~%")
    (mapcar (lambda (par)
              (format t "Color ~A: ~,2F%~%"
                      (car par)
                      (cadr par)))
            distribucion)
    (format t "================================================~%")
    distribucion))
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
