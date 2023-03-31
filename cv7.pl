%spojRS(A-B,C-D,E-F):-B=C,F=D,E=A.
spojRS(A-B,B-D,A-D).

suda_cisla([], []).
suda_cisla([X|Xs], [X|Ys]):-X mod 2 =:= 0,
                            !,suda_cisla(Xs, Ys).
suda_cisla([_|Xs], Ys):-suda_cisla(Xs, Ys).