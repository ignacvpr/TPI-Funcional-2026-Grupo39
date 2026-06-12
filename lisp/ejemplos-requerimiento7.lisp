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
