%explorando sintaxis basica de de erlang

% -module indica el nombre del modulo, debe coincidir con el nombre del archivo
-module(semaforo).

% -export indica que funciones están disponibles para usar desde afuera
% transicion/2 significa que la funcion transicion recibe 2 parametros
-export([transicion/2]).

