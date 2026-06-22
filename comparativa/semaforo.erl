-module(semaforo).
-export([transicion/2, timer/1]).

% ========================================================
% FUNCIÓN: transicion
% NATURALEZA: Pura
% ESTRATEGIA: Pattern Matching
% IMPACTO: No destructiva
% ========================================================
transicion(en_rojo, amarillo_intermitente) ->
    {en_rojo, "cambiar-a-amarillo-intermitente"};

transicion(en_amarillo_intermitente, verde) ->
    {en_amarillo_intermitente, "cambiar-a-verde"};

transicion(en_verde, amarillo_intermitente) ->
    {en_verde, "cambiar-a-amarillo-intermitente"};

transicion(en_amarillo_intermitente, amarillo) ->
    {en_amarillo_intermitente, "cambiar-a-amarillo"};

transicion(en_amarillo, amarillo_intermitente) ->
    {en_amarillo, "cambiar-a-amarillo-intermitente"};

transicion(en_amarillo_intermitente, rojo) ->
    {en_amarillo_intermitente, "cambiar-a-rojo"};

transicion(ColorActual, _) ->
    {ColorActual, accion_por_defecto}.

% ========================================================
% FUNCIÓN: timer
% NATURALEZA: Pura
% ESTRATEGIA: Pattern Matching con guardas
% IMPACTO: No destructiva
% ========================================================
timer(TiempoUnix) ->
    Posicion = TiempoUnix rem 225,
    if
        Posicion < 90 -> en_rojo;
        Posicion < 93 -> en_amarillo_intermitente;
        Posicion < 213 -> en_verde;
        Posicion < 216 -> en_amarillo_intermitente;
        Posicion < 222 -> en_amarillo;
        true -> en_amarillo_intermitente
    end.
