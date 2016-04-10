before(X,Y,L) :- append(Z,[Y|_],L), append(_,[X],Z).

composer(monteverdi, 1567, 1643).
composer(bach, 1685, 1750).
composer(vivaldi, 1678, 1750).
composer(mozart, 1756, 1791).
composer(haydn, 1732, 1809).
composer(beethoven, 1770, 1827).
composer(schubert, 1797, 1828).
composer(brahms, 1833, 1897).
composer(verdi, 1813, 1901).
composer(debussy, 1862, 1918).

overlap(X,Y,Z,W) :- X >= Z, X =< W.
overlap(X,Y,Z,W) :- Y >= Z, Y =< W.

contemporary(X,Y) :- composer(X,A,B), composer(Y,C,D), overlap(A,B,C,D), \+X=Y.

compare(X,Y) :- X =< Y.

% contemporary(X,Y) :- composer(A,D,E), composer(B,Z,W),
% overlap(D,E,Z,W).


rel(a,b).
rel(a,c).
rel(b,f).
rel(f,g).
clos(X,Y) :- rel(X,Y).
clos(X,Y) :- rel(X,Z), clos(Z,Y).

clos2(X,Y) :- rel(X,Y).
clos2(X,Y) :- clos2(Z,Y), rel(X,Z).

clos3(X,Y) :- rel(X,Z), clos3(Z,Y).
clos3(X,Y) :- rel(X,Y).

clos4(X,Y) :- clos4(Z,Y), rel(X,Z).
clos4(X,Y) :- rel(X,Y).

accRev([H|T],A,R) :- accRev(T,[H|A],R).
accRev([],A,A).

