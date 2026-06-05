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
