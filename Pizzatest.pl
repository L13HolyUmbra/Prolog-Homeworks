%  Organize the seating, so:
%  1  2
%  3  4
%  This means that "across" is always (n+2)%4
%  and "beside" is (n+1)%2

pos(1). pos(2). pos(3). pos(4).

beside(A,B) :- pos(A), B is (A+1) mod 2.
across(A,B) :- pos(A), B is (A+2) mod 4.

zebra(Donna,Danny,David,Doreen,
     Steak,Lasagna,Pizza,Chicken,
     Coke,Milk,Coffee,Water) :-
  % Our 4 given positive constraints
  beside(Doreen,Steak),
  Chicken=Coke,
  across(Lasagna,Milk),
  Donna=Water,
  % The men and women sat across from each other
  across(David,Danny),
  across(Doreen,Donna),
  % Ensure that each item is only in 1 position
  uniq_pos(Steak,Lasagna,Pizza,Chicken),
  uniq_pos(Coke,Milk,Coffee,Water),
  uniq_pos(Donna,Danny,David,Doreen),
  % The remaining two negative constraints.
  \+ David=Coffee,
  \+ Danny=Steak.

% Ensures that all 4 items are in unique positions.
uniq_pos(A,B,C,D) :-
  pos(A), pos(B), pos(C), pos(D),
  \+ A=B, \+ A=C, \+ A=D,
          \+ B=C, \+ B=D,
                  \+ C=D.
