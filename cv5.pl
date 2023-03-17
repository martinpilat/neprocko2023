match([], []).

match([one(X)|Rs], S):-append(X, Ss, S),
                       match(Rs, Ss).

match([star(X)|Rs], S):-append(X, Ss, S),
                        match([star(X)|Rs], Ss).
match([star(_)|Rs], S):-match(Rs, S).

match([plus(X)|Rs], S):-match([one(X),star(X)|Rs], S).

match([opt(X)|Rs], S):-append(X, Ss, S),
                       match(Rs, Ss).

match([opt(_)|Rs], S):-match(Rs, S).

generujVse(R, S):-between(1, 10, X), length(S, X), match(R, S).

pridejBVS(X, nil, t(nil, X, nil)).
pridejBVS(X, t(L, X, P), t(L, X, P)).
pridejBVS(X, t(L, H, P), t(L1, H, P)):-
                    X < H, pridejBVS(X, L, L1).
pridejBVS(X, t(L, H, P), t(L, H, P1)):-
                    X > H, pridejBVS(X, P, P1).

%seznamNaBVS(+S, -BVS):-BVS je binarni vyhledavaci 
%                       strom, ktery obsahuje prvky 
%                       seznamu S
seznamNaBVS(S, BVS):-seznamNaBVS(S, nil, BVS).
seznamNaBVS([], T, T).
seznamNaBVS([S|Ss], T, BVS):-pridejBVS(S, T, T1),
                             seznamNaBVS(Ss, T1, BVS).

stromNaSeznam(nil, []).
stromNaSeznam(t(L, H, P), S):-
        stromNaSeznam(L, LS),
        stromNaSeznam(P, PS),
        append(LS, [H|PS], S).

akce(V1-V2, C1, C2, 0-V2).
akce(V1-V2, C1, C2, V1-0).
akce(V1-V2, C1, C2, C1-V2).
akce(V1-V2, C1, C2, V1-C2).