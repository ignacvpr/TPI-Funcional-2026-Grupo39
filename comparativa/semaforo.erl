% ========================================================
% FUNCIÓN: transicion
% NATURALEZA: Pura
% ESTRATEGIA: Pattern Matching
% IMPACTO: No destructiva
% ========================================================
% mirando la funcion en lisp, cada caso del cond
% se convierte en una clausula separada en erlang
-module(semaforo).
-export([transicion/2, timer/1]).

% caso en-rojo a verde
transicion(en_rojo, verde) ->
    {en_rojo, "cambiar-a-verde"};

% caso en-verde a amarillo
transicion(en_verde, amarillo) ->
    {en_verde, "cambiar-a-amarillo"};

% caso en-amarillo a rojo
transicion(en_amarillo, rojo) ->
    {en_amarillo, "cambiar-a-rojo"};

% caso por defecto - transicion invalida
transicion(ColorActual, _) ->
    {ColorActual, accion_por_defecto}.

% ========================================================
% FUNCIÓN: timer
% NATURALEZA: Pura
% ESTRATEGIA: Pattern Matching con guardas
% IMPACTO: No destructiva
% ========================================================
timer(TiempoUnix) ->
    Posicion = TiempoUnix rem 216,
    if
        Posicion < 90 -> en_rojo;
        Posicion < 210 -> en_verde;
        true -> en_amarillo
    end.
