;; ========================================================
;; REQUERIMIENTO 7 - EJEMPLOS DE USO
;; Sistema de Semáforos Inteligentes
;; Grupo 39 — Paradigmas y Lenguajes 2026
;; ========================================================
;; NOTA: Cargar core.lisp antes de ejecutar estos ejemplos
;; En SBCL: (load "core.lisp") y luego (load "ejemplos-requerimiento7.lisp")
;; ========================================================

;; ========================================================
;; REQUERIMIENTO 1 - transicion
;; ========================================================

;; Camino normal - transiciones válidas
(transicion 'en-rojo 'verde)
;; Resultado esperado: (EN-ROJO "cambiar-a-verde")

(transicion 'en-verde 'amarillo)
;; Resultado esperado: (EN-VERDE "cambiar-a-amarillo")

(transicion 'en-amarillo 'rojo)
;; Resultado esperado: (EN-AMARILLO "cambiar-a-rojo")

;; Camino alternativo - transiciones inválidas
(transicion 'en-rojo 'amarillo)
;; Resultado esperado: (EN-ROJO ACCION-POR-DEFECTO)

(transicion 'en-verde 'rojo)
;; Resultado esperado: (EN-VERDE ACCION-POR-DEFECTO)

;; Caso de error - estado inexistente
(transicion 'en-azul 'verde)
;; Resultado esperado: (EN-AZUL ACCION-POR-DEFECTO)

;; ========================================================
;; REQUERIMIENTO 2 - timer
;; ========================================================

;; Camino normal
(timer 0)
;; Resultado esperado: EN-ROJO

(timer 89)
;; Resultado esperado: EN-ROJO

(timer 90)
;; Resultado esperado: EN-VERDE

(timer 210)
;; Resultado esperado: EN-AMARILLO

(timer 215)
;; Resultado esperado: EN-AMARILLO

;; Nuevo ciclo
(timer 216)
;; Resultado esperado: EN-ROJO


;; ========================================================
;; REQUERIMIENTO 3 - log-cambio-estado
;; NOTA: Requiere SBCL con local-time instalado
;; ========================================================

;; Camino normal
(log-cambio-estado 'en-rojo 'en-verde)
;; Resultado esperado: Tiempo [fecha legible]: la luz ha cambiado de EN-ROJO a EN-VERDE

(log-cambio-estado 'en-verde 'en-amarillo)


;; ========================================================
;; REQUERIMIENTO 4 - duracion-ciclo y recomendacion-ciclo
;; ========================================================

;; Camino normal
(duracion_ciclo)
;; Resultado esperado: 216

;; Camino normal
(recomendacion_ciclo (duracion_ciclo))
;; Resultado esperado: "Ciclo demasiado largo"

(recomendacion_ciclo 100)
;; Resultado esperado: "Ciclo perfecto"

;; Camino alternativo
(recomendacion_ciclo 20)
;; Resultado esperado: "El ciclo es muy corto"

;; Casos limite
(recomendacion_ciclo 35)
;; Resultado esperado: "Ciclo perfecto"

(recomendacion_ciclo 150)
;; Resultado esperado: "Ciclo perfecto"

;; Caso de error
(recomendacion_ciclo -5)
;; Resultado esperado: "El ciclo es muy corto"

;; ========================================================
;; REQUERIMIENTO 5 - ciclos-por-tiempo
;; ========================================================

;; Camino normal
(ciclos-por-tiempo 15)
;; Resultado esperado: 4

(ciclos-por-tiempo 60)
;; Resultado esperado: 16

;; Camino alternativo
(ciclos-por-tiempo 1)
;; Resultado esperado: 0

;; Caso de error
(ciclos-por-tiempo -5)
;; Resultado esperado: ERROR - duracion debe ser positiva

;; ========================================================
;; REQUERIMIENTO 6 - distribucion temporal
;; ========================================================

;; Camino normal
(distribucion-actual)
;; Resultado esperado:
;; ((ROJO 41.666...) (AMARILLO 2.777...) (VERDE 55.555...))

(imprimir-distribucion 90 6 120)
;; Resultado esperado:
;; === INFORME DE DISTRIBUCIÓN TEMPORAL (1 hora) ===
;; Color ROJO: 41.67%
;; Color AMARILLO: 2.78%
;; Color VERDE: 55.56%
;; ================================================

;; ========================================================
;; EXTENSIÓN 1 - timer con intermitencia
;; NOTA: La Extensión 1 esta implementada en amarillo-intermitente.lisp
;; Cargar ese archivo primero para probar estos ejemplos:
;; (load "amarillo-intermitente.lisp")
;; ========================================================

;; Camino normal
;; (timer 90)
;; Resultado esperado: EN-AMARILLO-INTERMITENTE

;; (timer 213)
;; Resultado esperado: EN-AMARILLO-INTERMITENTE

;; (timer 216)
;; Resultado esperado: EN-AMARILLO

;; (timer 222)
;; Resultado esperado: EN-AMARILLO-INTERMITENTE
