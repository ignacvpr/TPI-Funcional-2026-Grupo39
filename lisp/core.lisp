;; =========================================================
;; Sistema de Semáforos Inteligentes
;; Grupo 39 — Paradigmas y Lenguajes 2026
;; =========================================================
;; Requiere SBCL con Quicklisp y local-time instalados
;; =========================================================

(ql:quickload "local-time")

;;; ========================================================
;;  ITERACION 1
;;  - ciclo: rojo → verde → amarillo → rojo
;;  - duración total: 216 segundos
;;  - estados: en-rojo, en-verde, en-amarillo
;;; ========================================================


;; REQUERIMIENTO 1:
;; ========================================================
;; FUNCIÓN: transicion
;; NATURALEZA: Pura (siempre el mismo resultado. No imprime ni modifica nada mas)
;; ESTRATEGIA: Función Predicado
;; IMPACTO: No destructiva.
;; ========================================================

;; recibe el estado actual y al color que se quiere ir
;; retorna una lista con el estado y una accion a realizar
(defun transicion (color-actual cambiar-a) 
  (cond
    ;; comprueba si esta en rojo y quiere ir a verde
    ((and (equal color-actual 'en-rojo) (equal cambiar-a 'verde)) ;; equal compara si dos simbolos son exactamente el mismo
     (list color-actual "cambiar-a-verde"))

    ;; comprueba si esta en verde y quiere ir a amarillo
    ((and (equal color-actual 'en-verde) (equal cambiar-a 'amarillo))
     (list color-actual "cambiar-a-amarillo"))

    ;; comprueba si esta en amarillo y quiere ir a rojo
    ((and (equal color-actual 'en-amarillo) (equal cambiar-a 'rojo))
     (list color-actual "cambiar-a-rojo"))

    ;; retorna color actual y 'accion-por-defecto si la transición no es válida
    (t
     (list color-actual 'accion-por-defecto))))


;; REQUERIMIENTO 2:
;; ========================================================
;; FUNCIÓN: timer
;; NATURALEZA: Pura — mismo timestamp siempre devuelve el mismo color. No modifica nada externo.
;; ESTRATEGIA: Condicional simple
;; IMPACTO: No destructiva
;; ========================================================

;; recibe un tiempo Unix y devuelve el color correspondiente al momento especifico
(defun timer (tiempo-unix)
  ;; calcula en que punto del ciclo de 216 segundos estamos
  (let ((posicion (mod tiempo-unix 216)))
    ;; comparamos la posicion con el rango de cada color
    (cond
      ;; 0 a 89 segundos, rojo (dura 90 segundos)
      ((< posicion 90)  'en-rojo)

      ;; 90 a 209 segundos, verde (dura 120 segundos)
      ((< posicion 210)  'en-verde)

      ;; 210 a 215 segundos, amarillo (dura 6 segundos)
      (t  'en-amarillo))))

;; REQUERIMIENTO  3
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

;; REQUERIMIENTO  4
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

;; REQUERIMIENTO 5:
;; ============================================================
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
  "Calcula cuántos ciclos semafóricos completos entran en una cantidad de minutos dada.
   Entrada: duración en minutos (número positivo)
   Salida: número de ciclos completos (entero)"
  (cond
    ;; validación: la duración debe ser positiva
    ((not (and (numberp duracion-minutos)
               (> duracion-minutos 0)))
     (format t "ERROR: La duración debe ser un número positivo~%")
     nil)

    ;; caso válido: calculamos los ciclos
    (t
     (let* ((segundos-totales  (minutos-a-segundos duracion-minutos))
            ;; duración de un ciclo completo llamando a nuestra función dinámica
            (duracion-del-ciclo (duracion-ciclo 90 120 6))
            ;; dividimos y redondeamos hacia abajo
            (ciclos-completos   (floor (/ segundos-totales duracion-del-ciclo))))
       ciclos-completos))))


;; REQUERIMIENTO 6:
;; ============================================================
;; FUNCIÓN: calcular-porcentaje
;; NATURALEZA: Pura (mismo input siempre devuelve mismo output)
;; ESTRATEGIA: Función Simple (operación aritmética directa)
;; IMPACTO: No Destructiva
;; ============================================================
(defun calcular-porcentaje (tiempo-color duracion-total)
  "Calcula el porcentaje de tiempo que ocupa un color dentro de la duración total de un ciclo."
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
  (let* ((duracion-total (duracion-ciclo-total
                          tiempo-rojo
                          tiempo-amarillo
                          tiempo-verde))
         ;; creamos la lista de colores con sus tiempos
         (colores-tiempos (list
                            (list 'rojo      tiempo-rojo)
                            (list 'amarillo tiempo-amarillo)
                            (list 'verde    tiempo-verde))))
    ;; usamos mapcar para calcular el porcentaje de cada color
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
  "Calcula la distribución porcentual usando las reglas de negocio actuales: Rojo=90s, Amarillo=6s, Verde=120s"
  (informe-distribucion 90 6 120))


;; ============================================================
;; FUNCIÓN: imprimir-distribucion
;; NATURALEZA: Impura (efecto secundario: escribe en terminal)
;; ESTRATEGIA: Función de Orden Superior (utiliza mapcar)
;; IMPACTO: No Destructiva
;; ============================================================
(defun imprimir-distribucion (tiempo-rojo tiempo-amarillo tiempo-verde)
  "Muestra en terminal el informe de distribución temporal de forma legible para el operador."
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

;;  ITERACION 2 
;; ========================================================
;; EXTENSIÓN 1: INTERMITENCIA DE SEGURIDAD
;; ========================================================
;; Ciclo con intermitencia:
;; rojo -> amarillo-intermitente -> verde
;; -> amarillo-intermitente -> amarillo
;; -> amarillo-intermitente -> rojo
;; Duración total: 225 segundos
;; ========================================================

(defun color-valido-p (color)
  (member color
          '(en-rojo
            en-amarillo
            en-verde
            en-amarillo-intermitente)))

(defun transicion (color-actual cambiar-a)
  (cond
    ((and (eq color-actual 'en-rojo)
          (eq cambiar-a 'amarillo-intermitente))
     (list 'en-rojo "cambiar-a-amarillo-intermitente"))

    ((and (eq color-actual 'en-amarillo-intermitente)
          (eq cambiar-a 'verde))
     (list 'en-amarillo-intermitente "cambiar-a-verde"))

    ((and (eq color-actual 'en-verde)
          (eq cambiar-a 'amarillo-intermitente))
     (list 'en-verde "cambiar-a-amarillo-intermitente"))

    ((and (eq color-actual 'en-amarillo-intermitente)
          (eq cambiar-a 'amarillo))
     (list 'en-amarillo-intermitente "cambiar-a-amarillo"))

    ((and (eq color-actual 'en-amarillo)
          (eq cambiar-a 'amarillo-intermitente))
     (list 'en-amarillo "cambiar-a-amarillo-intermitente"))

    ((and (eq color-actual 'en-amarillo-intermitente)
          (eq cambiar-a 'rojo))
     (list 'en-amarillo-intermitente "cambiar-a-rojo"))

    (t
     (list color-actual 'accion-por-defecto))))

(defun timer (tiempo-unix)
  (let ((posicion (mod tiempo-unix 225)))
    (cond
      ((< posicion 90) 'en-rojo)
      ((< posicion 93) 'en-amarillo-intermitente)
      ((< posicion 213) 'en-verde)
      ((< posicion 216) 'en-amarillo-intermitente)
      ((< posicion 222) 'en-amarillo)
      (t 'en-amarillo-intermitente))))

;; ========================================================
;; REQUERIMIENTO 7 - EJEMPLOS DE USO
;; ========================================================
;; ========================================================
;; REQUERIMIENTO 1 - transicion
;; ========================================================

;; Caso normal
(transicion 'en-rojo 'amarillo-intermitente)
;; Resultado esperado:
;; (EN-ROJO "cambiar-a-amarillo-intermitente")

;; Caso normal
(transicion 'en-amarillo-intermitente 'verde)
;; Resultado esperado:
;; (EN-AMARILLO-INTERMITENTE "cambiar-a-verde")

;; Caso normal
(transicion 'en-verde 'amarillo-intermitente)
;; Resultado esperado:
;; (EN-VERDE "cambiar-a-amarillo-intermitente")

;; Caso inválido
(transicion 'en-rojo 'amarillo)
;; Resultado esperado:
;; (EN-ROJO ACCION-POR-DEFECTO)


;; ========================================================
;; REQUERIMIENTO 2 - timer
;; ========================================================

;; Caso normal
(timer 0)
;; Resultado esperado:
;; EN-ROJO

;; Caso normal
(timer 90)
;; Resultado esperado:
;; EN-AMARILLO-INTERMITENTE

;; Caso normal
(timer 100)
;; Resultado esperado:
;; EN-VERDE

;; Caso normal
(timer 213)
;; Resultado esperado:
;; EN-AMARILLO-INTERMITENTE

;; Caso normal
(timer 220)
;; Resultado esperado:
;; EN-AMARILLO

;; Caso normal
(timer 223)
;; Resultado esperado:
;; EN-AMARILLO-INTERMITENTE


;; ========================================================
;; REQUERIMIENTO 3 - log-cambio-estado
;; ========================================================

;; Caso normal
(log-cambio-estado 'en-rojo 'en-verde)

;; Caso normal
(log-cambio-estado 'en-verde 'en-amarillo)
