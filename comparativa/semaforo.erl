%explorando sintaxis basica de de erlang

% -module indica el nombre del modulo, debe coincidir con el nombre del archivo
-module(semaforo).

% -export indica que funciones están disponibles para usar desde afuera
% transicion/2 significa que la funcion transicion recibe 2 parametros
-export([transicion/2]).

% NOTAS SOBRE PATTERN MATCHING EN ERLANG
% en erlang una funcion puede tener multiples clausulas
% cada clausula se activa segun los parametros que recibe
% esto reemplaza el uso de cond/if que se usa en lisp

%===CLAUSULAS====
% una clausula es cada "version" de la funcion
% en erlang podes escribir la misma funcion varias veces con distintos parametros
% cada una de esas es una clausula
% cuando llamas a la funcion erlang prueba cada clausula de arriba hacia abajo
% y ejecuta la primera que coincida con los parametros que le pasaste
% si ninguna coincide usa la ultima que es el caso por defecto
