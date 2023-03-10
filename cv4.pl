rle([], []).
rle([X], [1-X]).
rle([X, X|Xs], [N1-X|Rs]):-rle([X|Xs], [N-X|Rs]),
                           N1 is N + 1.
rle([X, Y|Xs], [1-X, N-Y|Rs]):-X\=Y,
                        rle([Y|Xs], [N-Y|Rs]).

%otoc(+Seznam, -Manzes):-Manzes je Seznam pozpatku
otoc([], []).
otoc([X|Xs], SxX):-otoc(Xs, Sx),append(Sx, [X], SxX).

%rotoc(+S,-Z):-otoc(S, Z), ale rychle
rotoc(S, Z):-rotoc2(S, [], Z).
rotoc2([], O, O).
rotoc2([X|Xs], O, Z):-rotoc2(Xs, [X|O], Z).

%od1doN(N, S):-S je seznam [1,2,3,4...n]
od1doN(1, [1]).
od1doN(N, S):-N > 1, N1 is N - 1, od1doN(N1, S1), 
              append(S1, [N], S).

%odAdoB(A, B, S):-S je seznam hodnot [A, A+1, ..., B]
odAdoB(A, A, [A]).
odAdoB(A, B, [A|S]):-A < B, A1 is A + 1, odAdoB(A1, B, S).

prvekSeznam(X, [X|_]).
prvekSeznam(X, [_|Xs]):-prvekSeznam(X, Xs).

prvekStrom(X, t(L, _, _)):-prvekStrom(X, L).
prvekStrom(X, t(_, X, _)).
prvekStrom(X, t(_, _, P)):-prvekStrom(X, P).

pridejBVS(X, nil, t(nil, X, nil)).
pridejBVS(X, t(L, X, P), t(L, X, P)).
pridejBVS(X, t(L, H, P), t(L1, H, P)):-
                    X < H, pridejBVS(X, L, L1).
pridejBVS(X, t(L, H, P), t(L, H, P1)):-
                    X > H, pridejBVS(X, P, P1).