;; ========================================================
;; REQUERIMIENTO 7 - EJEMPLOS DE USO
;; Sistema de Semáforos Inteligentes
;; ========================================================
;; ========================================================
;; FUNCIÓN: duracion_ciclo
;; ========================================================
;; Caso normal
(duracion_ciclo)
;; Resultado esperado: 216
;; ========================================================
;; FUNCIÓN: recomendacion_ciclo
;; ========================================================
;; Caso normal
(recomendacion_ciclo (duracion_ciclo))
;; Resultado esperado:
;; "Ciclo demasiado largo"
;; Camino alternativo
(recomendacion_ciclo 100)
;; Resultado esperado:
;; "Ciclo perfecto"

;; Camino alternativo
(recomendacion_ciclo 20)
;; Resultado esperado:
;; "El ciclo es muy corto"

;; Caso límite inferior
(recomendacion_ciclo 35)
;; Resultado esperado:
;; "Ciclo perfecto"

;; Caso límite superior
(recomendacion_ciclo 150)
;; Resultado esperado:
;; "Ciclo perfecto"

;; Caso fuera del rango habitual
(recomendacion_ciclo -5)
;; Resultado esperado:
;; "El ciclo es muy corto"
 ;; ========================================================
;; REQUERIMIENTO 1 - transicion
;; ========================================================

;; Caso normal
(transicion 'en-rojo 'verde)
;; Resultado esperado:
;; (EN-ROJO "cambiar-a-verde")

;; Caso normal
(transicion 'en-verde 'amarillo)
;; Resultado esperado:
;; (EN-VERDE "cambiar-a-amarillo")

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

;; Cambio de estado
(timer 90)
;; Resultado esperado:
;; EN-AMARILLO

;; Caso normal
(timer 100)
;; Resultado esperado:
;; EN-VERDE
