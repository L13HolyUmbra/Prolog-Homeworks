boyfriend(dion).
girlfriend(rachel).

girlfriend(Y,X) :- boyfriend(X,Y).
boyfriend(Y,X) :- girlfriend(X,Y).
loves(X,Y) :- boyfriend(X,Y).
