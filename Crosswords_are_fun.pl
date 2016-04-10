% @Author Dion de Jong
% @Date 9-20-15
% @Version 1.0
% @Project Cryptoarithmetic Problem

% Solve for the unique letters, starting at the ones place for the
% numbers (the last letter in each word).
solution(C,R,O,S,A,D,N,G,E) :-
dig(S),
R is (S+S) mod 10, C1 is (S+S) // 10, R>0,
dig(S), dig(D),
E is (D+S+C1) mod 10, C10 is (D+S+C1) // 10,
dig(O), dig(A),
G is (O+A+C10) mod 10, C100 is (A+O+C10) // 10,
dig(R), dig(O),
N is (R+O+C100) mod 10, C1000 is (R+O+C100) // 10,
dig(C), C > 0, dig(R), R > 0,
A is (C+R+C1000) mod 10, D is (C+R+C1000) // 10,
unique_digits(C,R,O,S,A,D,N,G,E).

% Constrain the digits to be unique so that no two letter have the same
% value.
unique_digits(C,R,O,S,A,D,N,G,E) :-
dig(C), dig(R), dig(O), dig(S), dig(A), dig(D), dig(N), dig(G), dig(E),
\+ C=R, \+ C=O, \+ C=S, \+ C=A, \+ C=D, \+ C=N, \+ C=G, \+ C=E,
\+ R=O, \+ R=S, \+ R=A, \+ R=D, \+ R=N, \+ R=G, \+ R=E,
\+ O=S, \+ O=A, \+ O=D, \+ O=N, \+ O=G, \+ O=E,
\+ S=A, \+ S=D, \+ S=N, \+ S=G, \+ S=E,
\+ A=D, \+ A=N, \+ A=G, \+ A=E,
\+ D=N, \+ D=G, \+ D=E,
\+ N=G, \+ N=E,
\+ G=E.

% The digits
digit(0). digit(1). digit(2). digit(3). digit(4).
digit(5). digit(6). digit(7). digit(8). digit(9).
