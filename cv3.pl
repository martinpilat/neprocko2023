%suda_cisla(+Seznam, -SudaCislaSeznam):-SudaCislaSeznam jsou suda cisla ze Seznam
suda_cisla([], []).
suda_cisla([X|Xs], [X|Ys]):-X mod 2 =:= 0,
                            suda_cisla(Xs, Ys).
suda_cisla([X|Xs], Ys):-X mod 2 =\= 0,
                        suda_cisla(Xs, Ys).

%delka(+Seznam, -L):-L je delka seznamu Seznam
delka([], 0).
delka([_|Xs], L):-delka(Xs, L1), L is 1 + L1.

%soucet(+Seznam, -Suma):-Suma je soucet cisel z Seznam
soucet([], 0).
soucet([X|Xs], L):-soucet(Xs, L1), L is X + L1.

max(X, Y, X):-X >= Y.
max(X, Y, Y):-X < Y.
%maximum(+Seznam, -Max):-Max je maximum ze Seznamu
maximum([], -inf).
maximum([X|Xs], M):-maximum(Xs, M1),max(X, M1, M). 

%ojednavic(+Seznam, -SeznamPlus1):-SenzamPlus1 je Seznam, 
                                   %kde je ke kazdemu prvku prictena 1
ojednavic([], []).
ojednavic([X|Xs], [X1|Xs1]):-X1 is X + 1, 
                             ojednavic(Xs, Xs1).

plus1(X, Y):- Y is X + 1.
ojednavic2(Xs, Ys):- maplist(plus1, Xs, Ys).