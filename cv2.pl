cislo(0).
cislo(s(X)):-cislo(X).

%soucet(+C1, +C2, -S):-S je soucet C1 a C2
soucet(0, X, X).
soucet(s(X), Y, s(Z)):-soucet(X, Y, Z).

%soucin(+C1, +C2, -S):-S je soucin C1 a C2
soucin(0, _, 0).
soucin(s(X), Y, Z):-soucin(X, Y, Z1),
                    soucet(Z1, Y, Z).

%prvek(?X, +S):-X je prvek seznamu S
prvek(X, [X|_]).
prvek(X, [_|Xs]):-prvek(X, Xs).

%kart_soucin(X, Y, Z):-Z je prvek XxY
kart_soucin(X, Y, X1-Y1):-prvek(X1, X), 
                          prvek(Y1, Y).

%vymaz(X, S, SbezX):-SbezX je seznam S 
%                    bez vsech vyskytu X
vymaz(_, [], []).
vymaz(X, [X|Xs], Zbytek):-vymaz(X, Xs, Zbytek).
vymaz(X, [Y|Xs], [Y|Zbytek]):-X\=Y,vymaz(X, Xs, Zbytek).