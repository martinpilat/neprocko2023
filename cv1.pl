muz(adam).
muz(petr).
muz(martin).

zena(jana).
zena(klara).
zena(julie).

%rodic(X, Y):-X je rodic Y
rodic(petr, adam).
rodic(klara, jana).
rodic(adam, jana).
rodic(adam, martin).

%otec(X, Y):-X je otec Y
otec(X, Y):-rodic(X, Y),muz(X).

%bratr(X, Y):-X je bratr Y 
%             (X a Y maji alespon jednoho spolecneho rodice)
bratr(X, Y):-dif(X,Y), rodic(Z, X), rodic(Z, Y), muz(X).