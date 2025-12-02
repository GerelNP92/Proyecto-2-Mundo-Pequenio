:- dynamic mostro/4.

% Base de datos de mostros
% mostro(nombre, nivel, atributo, poder).
mostro(mostroUno, 5, luz, 2100).
mostro(mostroDos, 7, luz, 2400).
mostro(mostroTres, 7, viento, 2500).

% Predicado auxiliar para verificar si dos mostros comparten exactamente una característica
compartenUnaCaracteristica(mostro(_, N1, A1, P1), mostro(_, N2, A2, P2)) :-
    % Contamos cuántas características comparten
    (N1 = N2 -> CuentaNivel = 1 ; CuentaNivel = 0),
    (A1 = A2 -> CuentaAtributo = 1 ; CuentaAtributo = 0),
    (P1 = P2 -> CuentaPoder = 1 ; CuentaPoder = 0),
    Total is CuentaNivel + CuentaAtributo + CuentaPoder,
    Total =:= 1.

% ternaMundoChiquito/3
% Encuentra todas las ternas (Mano, Mazo1, Mazo2) que cumplen con las reglas
ternaMundoChiquito(Mano, Mazo1, Mazo2) :-
    % Obtenemos un mostro de la mano
    mostro(Mano, NivelMano, AtributoMano, PoderMano),
    
    % Buscamos un mostro del mazo que comparta exactamente una característica con el de la mano
    mostro(Mazo1, NivelMazo1, AtributoMazo1, PoderMazo1),
    compartenUnaCaracteristica(
        mostro(Mano, NivelMano, AtributoMano, PoderMano),
        mostro(Mazo1, NivelMazo1, AtributoMazo1, PoderMazo1)
    ),
    
    % Buscamos un mostro del mazo que comparta exactamente una característica con el revelado del mazo
    mostro(Mazo2, NivelMazo2, AtributoMazo2, PoderMazo2),
    compartenUnaCaracteristica(
        mostro(Mazo1, NivelMazo1, AtributoMazo1, PoderMazo1),
        mostro(Mazo2, NivelMazo2, AtributoMazo2, PoderMazo2)
    ).

% mundoChiquito/0
% Imprime todas las ternas válidas
mundoChiquito :-
    forall(
        ternaMundoChiquito(M1, M2, M3),
        format('~w ~w ~w~n', [M1, M2, M3])
    ).

% agregarMostro/0
% Lee información de un mostro desde consola y lo agrega a la base de conocimiento
agregarMostro :-
    write('=== Agregar Nuevo Mostro ==='), nl,
    write('Ingrese el nombre del mostro (sin espacios): '),
    read(Nombre),
    
    write('Ingrese el nivel (1-12): '),
    read(Nivel),
    
    % Validar nivel
    (   (Nivel >= 1, Nivel =< 12)
    ->  true
    ;   write('Error: El nivel debe estar entre 1 y 12'), nl, fail
    ),
    
    write('Ingrese el atributo (agua/fuego/viento/tierra/luz/oscuridad/divino): '),
    read(Atributo),
    
    % Validar atributo
    (   member(Atributo, [agua, fuego, viento, tierra, luz, oscuridad, divino])
    ->  true
    ;   write('Error: Atributo no válido'), nl, fail
    ),
    
    write('Ingrese el poder (múltiplo de 50): '),
    read(Poder),
    
    % Validar poder
    (   (Poder mod 50 =:= 0, Poder >= 0)
    ->  true
    ;   write('Error: El poder debe ser un múltiplo de 50'), nl, fail
    ),
    
    % Agregar el mostro a la base de conocimiento
    assertz(mostro(Nombre, Nivel, Atributo, Poder)),
    
    format('¡Mostro ~w agregado exitosamente!~n', [Nombre]),
    format('Detalles: Nivel ~w, Atributo ~w, Poder ~w~n', [Nivel, Atributo, Poder]).